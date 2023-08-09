using ArviZPythonPlots
using PythonCall
using Test

@testset "rcParams" begin
    @testset "rcParams" begin
        @test rcParams isa Py
        @test pyisinstance(rcParams, ArviZPythonPlots.arviz.rcparams.RcParams)
        @test pyhasitem(rcParams, "plot.backend")
    end

    @testset "defaults" begin
        @test pyconvert(Int, rcParams["data.index_origin"]) == 1
    end

    @testset "rc_context" begin
        def_backend = rcParams["plot.backend"]
        rcParams["plot.backend"] = "matplotlib"
        pywith(rc_context(; rc=Dict("plot.backend" => "bokeh"))) do _
            @test pyconvert(String, rcParams["plot.backend"]) == "bokeh"
            return nothing
        end
        @test pyconvert(String, rcParams["plot.backend"]) == "matplotlib"
        rcParams["plot.backend"] = def_backend
    end
end
