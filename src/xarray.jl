# DimensionalData's PythonCall extension converts `AbstractDimArray`/`AbstractDimStack` to
# `xarray.DataArray`/`xarray.Dataset`, but only when asked to with `xarray=true` (or its
# `xarray_convert` preference). Since our wrappers convert transparently, we always ask for
# it, always copy (DimensionalData can only avoid copying arrays numpy can share memory
# with), and first handle the Julia-specific cases DimensionalData leaves to the caller.
function _to_xarray(data; kwargs...)
    return Py(_prepare_for_xarray(data); xarray=true, copy=true, kwargs...)
end
_to_xarray(data::Dataset; kwargs...) = _to_xarray(parent(data); kwargs...)

# more specific than `topytype(::AbstractArray{<:Real})`/`topytype(::AbstractVector{<:Real})`
# (src/utils.jl), which would otherwise convert a `DimArray` to a bare numpy array
topytype(data::DimensionalData.AbstractDimArray) = _to_xarray(data)
topytype(data::DimensionalData.AbstractDimStack) = _to_xarray(data)

# unlike a generic `DimStack`, a `Dataset` always converts to `xarray.Dataset`, like
# `InferenceData` always converts to `xarray.DataTree`
PythonCall.Py(data::Dataset; kwargs...) = _to_xarray(data; kwargs...)

function PythonCall.Py(data::InferenceData)
    groups = NamedTuple(data)
    return xarray.DataTree.from_dict(topytype(Dict(pairs(groups))))
end

_prepare_for_xarray(data) = _prepare_lookups(data)

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
_xarray_lookup(lookup) = nothing
