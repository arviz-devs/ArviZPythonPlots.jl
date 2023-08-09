PythonCall.Py(data::Dataset) = _to_xarray(data)

function PythonCall.Py(data::InferenceData)
    groups = NamedTuple(data)
    return arviz.InferenceData(; map(topytype, groups)...)
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
    coords = Dict(zip(dims, DimensionalData.index(data_dims)))
    default_dims = ()
    values = parent(data)
    if Missing <: eltype(values)
        # passing `missing` to Python causes the array to have a `PythonCall.jlwrap` dtype
        values = replace(values, missing => NaN)
    end
    metadata = pairs(DimensionalData.metadata(data))
    kwargs = (; var_name, dims, coords, default_dims)
    pykwargs = map(topytype, kwargs)
    return da = arviz.numpy_to_data_array(topytype(values); pykwargs...)
    # if !isempty(metadata)
    #    da.attrs = metadata
    # end
    # return da
end
