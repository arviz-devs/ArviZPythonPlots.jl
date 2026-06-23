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

        variables = Dict(collect(o.data_vars.variables.items()))
        @test pystr("x") ∈ keys(variables)
        @test Bool(pyeq(Py(x), variables[pystr("x")].values).all())
        @test Bool(variables[pystr("x")].dims == pytuple(pystr.(xdims)))

        @test pystr("y") ∈ keys(variables)
        @test Bool(pyeq(Py(y), variables[pystr("y")].values).all())
        @test Bool(
            variables[pystr("y")].dims ==
            pytuple(pystr.(("chain", "draw", "ydim1", "shared"))),
        )
    end

    @testset "DimArray -> xarray" begin
        xdims = (:chain, :draw, Dim{:shared}(["s1", "s2", "s3"]))
        x = DimArray(randn(4, 100, 3), xdims; name=:x)

        o = Py(x)
        @test o isa Py
        @test pyisinstance(o, ArviZPythonPlots.xarray.DataArray)
        @test Bool(pyeq(Py(x), o.values).all())
        @test Bool(o.dims == pytuple(pystr.((:chain, :draw, :shared))))
        @test pyeq(
            Bool,
            pylist(o.coords["shared"].values),
            pylist(parent(DimensionalData.lookup(x, :shared))),
        )

        # `topytype` must dispatch to the same conversion, not the generic
        # `AbstractArray{<:Real}` -> bare numpy array shortcut (src/utils.jl)
        t = ArviZPythonPlots.topytype(x)
        @test pyisinstance(t, ArviZPythonPlots.xarray.DataArray)
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
