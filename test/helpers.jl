using ArviZPythonPlots
using Random

function random_dim_array(var_name, dims, coords, default_dims=())
    _dims = (default_dims..., dims...)
    _coords = NamedTuple{_dims}(getproperty.(Ref(coords), _dims))
    size = map(length, values(_coords))
    data = randn(size)
    return DimArray(data, _coords; name=var_name)
end

function random_dim_stack(var_names, dims, coords, metadata, default_dims=(:draw, :chain))
    dim_arrays = map(var_names) do k
        return random_dim_array(k, getproperty(dims, k), coords, default_dims)
    end
    return DimStack(dim_arrays...; metadata)
end

random_dataset(args...) = Dataset(random_dim_stack(args...))

function random_data()
    var_names = (:a, :b)
    data_names = (:y,)
    coords = (
        chain=1:4, draw=1:100, shared=["s1", "s2", "s3"], dima=1:4, dimb=2:6, dimy=1:5
    )
    dims = (a=(:shared, :dima), b=(:shared, :dimb), y=(:shared, :dimy))
    metadata = (inference_library="PPL",)
    posterior = random_dataset(var_names, dims, coords, metadata)
    posterior_predictive = random_dataset(data_names, dims, coords, metadata)
    prior = random_dataset(var_names, dims, coords, metadata)
    prior_predictive = random_dataset(data_names, dims, coords, metadata)
    observed_data = random_dataset(data_names, dims, coords, metadata, ())
    return InferenceData(;
        posterior, posterior_predictive, prior, prior_predictive, observed_data
    )
end

function test_idata_approx_equal(
    idata1::InferenceData, idata2::InferenceData; check_metadata=true
)
    @test keys(idata1) === keys(idata2)
    for (ds1, ds2) in zip(idata1, idata2)
        @test issetequal(keys(ds1), keys(ds2))
        for var_name in keys(ds1)
            da1 = ds1[var_name]
            da2 = ds2[var_name]
            @test da1 ≈ da2
            dims1 = DimensionalData.dims(da1)
            dims2 = DimensionalData.dims(da2)
            @test DimensionalData.name(dims1) == DimensionalData.name(dims2)
            @test DimensionalData.index(dims1) == DimensionalData.index(dims2)
        end
        if check_metadata
            metadata1 = DimensionalData.metadata(ds1)
            metadata2 = DimensionalData.metadata(ds2)
            @test issetequal(keys(metadata1), keys(metadata2))
            for k in keys(metadata1)
                Symbol(k) === :created_at && continue
                @test metadata1[k] == metadata2[k]
            end
        end
    end
end
