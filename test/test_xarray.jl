using ArviZPythonPlots
using DimensionalData
using InferenceObjects
using PythonCall
using Test

@testset "xarray interop" begin
    @testset "Dataset -> xarray" begin
        nchains = 4
        ndraws = 100
        nshared = 3
        xdims = (:chain, :draw, :shared)
        x = DimArray(randn(nchains, ndraws, nshared), xdims)
        ydims = (:chain, :draw, Dim{:ydim1}(Any["a", "b"]), :shared)
        y = DimArray(randn(nchains, ndraws, 2, nshared), ydims)
        metadata = Dict(:prop1 => "val1", :prop2 => "val2")
        ds = Dataset((; x, y); metadata)
        o = Py(ds)
        @test o isa Py
        @test pyisinstance(o, ArviZPythonPlots.xarray.Dataset)

        @test issetequal(
            Symbol.(collect(o.coords.keys())), (:chain, :draw, :shared, :ydim1)
        )
        for (dim, coord) in o.coords.items()
            @test pyeq(
                Bool,
                pylist(coord.values),
                pylist(parent(DimensionalData.lookup(ds, Symbol(dim)))),
            )
        end

        # DimensionalData reverses the dimensions so that the fast axis is the same in
        # Julia and Python
        variables = Dict(collect(o.data_vars.variables.items()))
        @test pystr("x") ∈ keys(variables)
        @test pyconvert(Array, variables[pystr("x")].values) ==
            permutedims(parent(x), ndims(x):-1:1)
        @test Bool(variables[pystr("x")].dims == pytuple(pystr.(reverse(xdims))))

        @test pystr("y") ∈ keys(variables)
        @test pyconvert(Array, variables[pystr("y")].values) ==
            permutedims(parent(y), ndims(y):-1:1)
        @test Bool(
            variables[pystr("y")].dims ==
            pytuple(pystr.(("shared", "ydim1", "draw", "chain"))),
        )
    end

    @testset "DimArray -> xarray" begin
        xdims = (:chain, :draw, Dim{:shared}(["s1", "s2", "s3"]))
        x = DimArray(randn(4, 100, 3), xdims; name=:x)

        # `topytype` must not take the generic `AbstractArray{<:Real}` -> bare numpy array
        # shortcut (src/utils.jl)
        o = ArviZPythonPlots.topytype(x)
        @test o isa Py
        @test pyisinstance(o, ArviZPythonPlots.xarray.DataArray)
        @test pyconvert(Array, o.values) == permutedims(parent(x), ndims(x):-1:1)
        @test Bool(o.dims == pytuple(pystr.((:shared, :draw, :chain))))
        @test pyeq(
            Bool,
            pylist(o.coords["shared"].values),
            pylist(parent(DimensionalData.lookup(x, :shared))),
        )
        # dimensions without a lookup get 1-based coordinates
        @test pyeq(Bool, pylist(o.coords["draw"].values), pylist(1:100))
    end

    @testset "InferenceData -> Py" begin
        idata = random_data()
        pyidata = Py(idata)
        @test pyidata isa Py
        @test pyisinstance(pyidata, ArviZPythonPlots.xarray.DataTree)
        for group in keys(idata)
            pyds = Py(idata[group])
            @test pyds isa Py
            @test pyisinstance(pyds, ArviZPythonPlots.xarray.Dataset)
            @test pyall(pyidata[pystr(group)].dataset == pyds)
        end
    end
end
