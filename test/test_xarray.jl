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

    @testset "data is copied only if numpy can't share memory with it" begin
        values = randn(4, 5)
        x = DimArray(values, (:chain, :draw))
        o = ArviZPythonPlots.topytype(x)
        values[1, 1] = 42
        @test pyconvert(Float64, o.isel(; chain=0, draw=0).item()) == 42

        # only the layers numpy can't share memory with are copied
        values = randn(4, 5)
        ds = Dataset((;
            x=DimArray(values, (:chain, :draw)),
            y=DimArray(view(values, :, [1, 3]), (:chain, :pair)),
        ))
        o = Py(ds)
        values[1, 1] = 42
        @test pyconvert(Float64, o.x.isel(; chain=0, draw=0).item()) == 42
        @test pyconvert(Float64, o.y.isel(; chain=0, pair=0).item()) != 42

        # copying can be requested
        o = Py(ds; copy=true)
        values[1, 1] = 3.14
        @test pyconvert(Float64, o.x.isel(; chain=0, draw=0).item()) == 42

        # elements numpy can't share memory with are copied
        ds = Dataset((; x=DimArray(randn(3), :draw), y=DimArray(["a", "b", "c"], :draw)))
        o = Py(ds)
        @test pyconvert(Vector{String}, o.y.values) == ["a", "b", "c"]
    end

    @testset "arrays numpy can't share memory with" begin
        values = randn(4, 5)
        @testset for x in (
            DimArray(view(values, :, [1, 3]), (:chain, :draw)),
            DimArray(PermutedDimsArray(values, (2, 1)), (:draw, :chain)),
            DimArray(1:5, :draw),
            DimArray(reshape(1:20, 4, 5), (:chain, :draw)),
        )
            o = ArviZPythonPlots.topytype(x)
            @test pyisinstance(o, ArviZPythonPlots.xarray.DataArray)
            @test pyconvert(Array, o.values) == permutedims(collect(x), ndims(x):-1:1)
        end
    end

    @testset "missing values become NaN" begin
        @testset for (values, expected) in (
            ([1.0, missing, 3.0], [1.0, NaN, 3.0]),
            (Float32[1, 2, 3], Float32[1, 2, 3]),
            (Union{Missing,Int}[1, 2, 3], [1.0, 2.0, 3.0]),
            ([1, missing, 3], [1.0, NaN, 3.0]),
            ([true, missing], [1.0, NaN]),
            ([missing, missing], [NaN, NaN]),
        )
            x = DimArray(values, :draw)
            o = ArviZPythonPlots.topytype(x)
            @test pyconvert(String, o.dtype.name) == lowercase(string(eltype(expected)))
            @test isequal(pyconvert(Vector, o.values), expected)
        end

        ds = Dataset((; x=DimArray([1, missing, 3], :draw), y=DimArray([1, 2, 3], :draw)))
        o = Py(ds)
        @test isequal(pyconvert(Vector, o.x.values), [1.0, NaN, 3.0])
        @test pyconvert(Vector, o.y.values) == [1, 2, 3]
    end

    @testset "Symbol lookups become strings" begin
        x = DimArray(randn(3), Dim{:school}([:b, :a, :c]); name=:x)
        @testset for o in (ArviZPythonPlots.topytype(x), Py(Dataset((; x))).x)
            @test pyconvert(Vector{String}, o.coords["school"].values) == ["b", "a", "c"]
            @test pyconvert(Float64, o.sel(; school="a").item()) == x[school = At(:a)]
        end
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
