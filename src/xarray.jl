# Utilities for customizing conversion of DimensionalData/InferenceObjects types to xarray

# DimensionalData's PythonCall extension converts `AbstractDimArray`/`AbstractDimStack` to
# `xarray.DataArray`/`xarray.Dataset`, but only when asked to with `xarray=true` (or its
# `xarray_convert` preference). Since our wrappers convert transparently, we always ask for
# it, copy only what numpy can't share memory with (DimensionalData otherwise errors), and
# first handle the Julia-specific cases DimensionalData leaves to the caller.
function _to_xarray(data; kwargs...)
    data = _prepare_for_xarray(data)
    copy = !_can_share_memory(data)
    return Py(data; xarray=true, copy, kwargs...)
end
_to_xarray(data::Dataset; kwargs...) = _to_xarray(parent(data); kwargs...)

# more specific than `topytype(::AbstractArray{<:Real})`/`topytype(::AbstractVector{<:Real})`
# (src/utils.jl), which would otherwise convert a `DimArray` to a bare numpy array
topytype(data::DimensionalData.AbstractDimArray) = _to_xarray(data)
topytype(data::DimensionalData.AbstractDimStack) = _to_xarray(data)

function _prepare_for_xarray(data::DimensionalData.AbstractDimArray)
    return _make_shareable(_replace_missing(_prepare_lookups(data)))
end
function _prepare_for_xarray(data::DimensionalData.AbstractDimStack)
    return DimensionalData.maplayers(
        _make_shareable ∘ _replace_missing, _prepare_lookups(data)
    )
end

function _prepare_lookups(data)
    lookups = map(DimensionalData.dims(data)) do dim
        return DimensionalData.name(dim) => _xarray_lookup(DimensionalData.lookup(dim))
    end
    new_lookups = filter(!isnothing ∘ last, lookups)
    isempty(new_lookups) && return data
    return DimensionalData.set(data, new_lookups...)
end

# DimensionalData gives dimensions without a lookup no coordinates, which xarray (and so
# arviz) would then index from 0, so we give them 1-based lookups instead
_xarray_lookup(::DimensionalData.NoLookup) = DimensionalData.Sampled
# `Symbol`s would otherwise be passed as Julia objects, which can't be selected with a `str`
_xarray_lookup(lookup::DimensionalData.Lookup{Symbol}) = string.(parent(lookup))
_xarray_lookup(lookup) = nothing

# Python has no equivalent of `missing`, so for real values we replace it with `NaN`,
# promoting to float if necessary
function _replace_missing(data::DimensionalData.AbstractDimArray)
    S = nonmissingtype(eltype(data))
    (Missing <: eltype(data) && S <: Real) || return data
    T = S === Union{} ? Float64 : float(S)
    return map(x -> ismissing(x) ? T(NaN) : T(x), data)
end

# numpy can share memory with the arrays juliacall exposes an array interface for
function _can_share_memory(data::DimensionalData.AbstractDimArray)
    return pyhasattr(Py(parent(data)), "__array_interface__")
end
function _can_share_memory(data::DimensionalData.AbstractDimStack)
    return all(_can_share_memory, DimensionalData.layers(data))
end

# numpy can't share memory with e.g. non-strided views or ranges, but it can once they are
# copied into an `Array` (if their elements are bits types), so that the other layers of a
# stack don't need to be copied too
function _make_shareable(data::DimensionalData.AbstractDimArray)
    (isbitstype(eltype(data)) && !_can_share_memory(data)) || return data
    return DimensionalData.modify(Array, data)
end
