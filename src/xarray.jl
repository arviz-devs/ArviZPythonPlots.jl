PythonCall.Py(data::Dataset) = _to_xarray(data)

Base.convert(::Type{Dataset}, obj::Py) = Dataset(_dimstack_from_xarray(obj))

function PythonCall.Py(data::InferenceData)
    groups = NamedTuple(data)
    return arviz.InferenceData(; map(Py, groups)...)
end

function ArviZ.convert_to_inference_data(obj::Py; dims=nothing, coords=nothing, kwargs...)
    if pyisinstance(obj, arviz.InferenceData)
        group_names = obj.groups()
        groups = (
            Symbol(name) => convert(Dataset, getindex(obj, name)) for name in group_names
        )
        return InferenceData(; groups...)
    else
        # Python ArviZ requires dims and coords be dicts matching to vectors
        pydims = dims === nothing ? dims : Dict(k -> collect(dims[k]) for k in keys(dims))
        pycoords =
            dims === nothing ? dims : Dict(k -> collect(coords[k]) for k in keys(coords))
        return arviz.convert_to_inference_data(obj; dims=pydims, coords=pycoords, kwargs...)
    end
end

function _dimstack_from_xarray(o::Py)
    pyisinstance(o, xarray.Dataset) ||
        throw(ArgumentError("argument is not an `xarray.Dataset`."))
    var_names = collect(o.data_vars)
    data = [_dimarray_from_xarray(getindex(o, name)) for name in var_names]
    metadata = OrderedDict{Symbol,Any}(Symbol(k) => v for (k, v) in o.attrs)
    return DimensionalData.DimStack(data...; metadata)
end

function _dimarray_from_xarray(o::Py)
    pyisinstance(o, xarray.DataArray) ||
        throw(ArgumentError("argument is not an `xarray.DataArray`."))
    name = Symbol(o.name)
    data = _process_pyarray(o.to_numpy())
    coords = PythonCall.PyDict(o.coords)
    dims = Tuple(
        map(d -> _wrap_dims(Symbol(d), _process_pyarray(coords[d].values)), o.dims)
    )
    attrs = OrderedDict{Symbol,Any}(Symbol(k) => v for (k, v) in o.attrs)
    metadata = isempty(attrs) ? DimensionalData.NoMetadata() : attrs
    return DimensionalData.DimArray(data, dims; name, metadata)
end

_process_pyarray(x) = x
# NOTE: sometimes strings fail to convert to Julia types, so we try to force them here
function _process_pyarray(x::Union{Py,<:AbstractVector{Py}})
    return map(z -> z isa Py ? PyAny(z)::Any : z, x)
end

# wrap dims in a `Dim`, converting to an AbstractRange if possible
function _wrap_dims(name::Symbol, dims::AbstractVector{<:Real})
    D = DimensionalData.Dim{name}
    start = dims[begin]
    stop = dims[end]
    n = length(dims)
    step = (stop - start) / (n - 1)
    isrange = all(Iterators.drop(eachindex(dims), 1)) do i
        return (dims[i] - dims[i - 1]) ≈ step
    end
    return if isrange
        if step == 1
            D(UnitRange(start, stop))
        else
            D(range(start, stop; length=n))
        end
    else
        D(dims)
    end
end
_wrap_dims(name::Symbol, dims::AbstractVector) = DimensionalData.Dim{name}(dims)

function _to_xarray(data::DimensionalData.AbstractDimStack)
    data_vars = Iterators.map(pairs(DimensionalData.layers(data))) do (k, v)
        pystr(k) => _to_xarray(v)
    end |> pydict
    attrs = pydict(pairs(DimensionalData.metadata(data)))
    return xarray.Dataset(data_vars; attrs)
end

function _to_xarray(data::DimensionalData.AbstractDimArray)
    var_name = pystr(DimensionalData.name(data))
    data_dims = DimensionalData.dims(data)
    dims = pylist(map(pystr, DimensionalData.name(data_dims)))
    coords = pydict(Dict(zip(dims, map(pylist, DimensionalData.index(data_dims)))))
    default_dims = pylist()
    values = parent(data)
    if Missing <: eltype(values)
        # passing `missing` to Python causes the array to have a `PythonCall.jlwrap` dtype
        values = replace(values, missing => NaN)
    end
    metadata = pydict(DimensionalData.metadata(data))
    return da = arviz.numpy_to_data_array(values; var_name, dims, coords, default_dims)
    # if !isempty(metadata)
    #    da.attrs = metadata
    # end
    # return da
end
