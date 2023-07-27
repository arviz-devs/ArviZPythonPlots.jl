using ArviZPyPlot
using Test

@testset "rcParams" begin
    @testset "rcParams" begin
        @test rcParams isa ArviZPyPlot.RcParams
        @test pyisinstance(PyObject(rcParams), ArviZPyPlot.arviz.rcparams.RcParams)
        pyrcParams = ArviZPyPlot.arviz.rcParams
        @test rcParams == pyrcParams
        @test ArviZPyPlot.RcParams(pyrcParams) isa ArviZPyPlot.RcParams{Any,Any}
        @test isa(
            convert(ArviZPyPlot.RcParams{String,Union{Int64,String}}, pyrcParams),
            ArviZPyPlot.RcParams{String,Union{Int64,String}},
        )
        @test convert(ArviZPyPlot.RcParams, pyrcParams) isa ArviZPyPlot.RcParams
        @test haskey(rcParams, "plot.backend")
        def_backend = rcParams["plot.backend"]
        @test ("plot.backend" => def_backend) ∈ rcParams
        rcParams["plot.backend"] = "matplotlib"
        @test rcParams["plot.backend"] == "matplotlib"
        rcParams["plot.backend"] = "bokeh"
        @test rcParams["plot.backend"] == "bokeh"
        @test_throws KeyError rcParams["blah"]
        @test_throws KeyError rcParams["blah"] = 3
        @test_throws ErrorException rcParams["plot.backend"] = "blah"
        @test get(rcParams, "blah", "def") == "def"
        @test Dict(map(p -> Pair(p...), zip(keys(rcParams), values(rcParams)))) == rcParams
        rcParams["plot.backend"] = def_backend
    end

    @testset "defaults" begin
        @test rcParams["data.index_origin"] == 1
    end

    @testset "with_rc_context" begin
        def_backend = rcParams["plot.backend"]
        rcParams["plot.backend"] = "matplotlib"
        with_rc_context(; rc=Dict("plot.backend" => "bokeh")) do
            @test rcParams["plot.backend"] == "bokeh"
            return nothing
        end
        rcParams["plot.backend"] = def_backend
    end
end
