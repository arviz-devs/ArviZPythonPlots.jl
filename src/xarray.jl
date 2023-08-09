PythonCall.Py(data::Dataset) = _to_xarray(data)

function PythonCall.Py(data::InferenceData)
    groups = NamedTuple(data)
    return arviz.InferenceData(; map(Py, groups)...)
end

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
