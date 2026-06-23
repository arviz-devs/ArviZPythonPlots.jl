PythonCall.Py(data::Dataset) = _to_xarray(data)
PythonCall.Py(data::DimensionalData.AbstractDimArray) = _to_xarray(data)

# more specific than `topytype(::AbstractArray{<:Real})`/`topytype(::AbstractVector{<:Real})`
# (src/utils.jl), which would otherwise convert a `DimArray` to a bare numpy array before it
# ever reaches the generic `Py(x)` fallback that calls the method above
topytype(data::DimensionalData.AbstractDimArray) = _to_xarray(data)

function PythonCall.Py(data::InferenceData)
    groups = NamedTuple(data)
    return xarray.DataTree.from_dict(topytype(Dict(pairs(groups))))
end

function _to_xarray(data::DimensionalData.AbstractDimStack)
    data_vars = map(_to_xarray, DimensionalData.layers(data))
    attrs = pairs(DimensionalData.metadata(data))
    return xarray.Dataset(topytype(data_vars); attrs=topytype(attrs))
end

function _to_xarray(data::DimensionalData.AbstractDimArray)
    var_name = DimensionalData.name(data)
    data_dims = DimensionalData.dims(data)
    dims = DimensionalData.name(data_dims)
    coords = Dict(zip(dims, parent.(DimensionalData.lookup(data_dims))))
    sample_dims = ()
    values = parent(data)
    if Missing <: eltype(values)
        # passing `missing` to Python causes the array to have a `PythonCall.jlwrap` dtype
        values = replace(values, missing => NaN)
    end
    metadata = pairs(DimensionalData.metadata(data))
    kwargs = (; dims, coords, sample_dims)
    pykwargs = map(topytype, kwargs)
    return da = arviz.ndarray_to_dataarray(
        Py(values).to_numpy(), topytype(var_name); pykwargs...
    )
    # if !isempty(metadata)
    #    da.attrs = metadata
    # end
    # return da
end
