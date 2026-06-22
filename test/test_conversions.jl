using ArviZExampleData
using ArviZPythonPlots
using PosteriorStats
using PythonCall
using Test

@testset "conversions" begin
    @testset "PSISLOOResult" begin
        idata = load_example_data("centered_eight")
        loo_result = loo(idata; reff=1)
        loo_py_result = ArviZPythonPlots.arviz.loo(idata; pointwise=true, reff=1)
        py_loo_result = Py(loo_result)
        @test pyconvert(String, py_loo_result.kind) == "loo"
        @test pyconvert(Float64, py_loo_result.elpd) ≈
            pyconvert(Float64, loo_py_result.elpd) rtol = 1e-3
        @test pyconvert(Float64, py_loo_result.se) ≈ pyconvert(Float64, loo_py_result.se) rtol =
            1e-1
        @test pyconvert(Float64, py_loo_result.p) ≈ pyconvert(Float64, loo_py_result.p) rtol =
            1e-3
        @test pyconvert(Array{Float64}, py_loo_result.elpd_i.values) ≈
            pyconvert(Array{Float64}, loo_py_result.elpd_i.values) rtol = 1e-3
        @test pyconvert(Array{Float64}, py_loo_result.pareto_k.values) ≈
            pyconvert(Array{Float64}, loo_py_result.pareto_k.values) rtol = 1e-1
    end
    isdefined(PosteriorStats, :WAICResult) && @testset "WAICResult" begin
        idata = load_example_data("centered_eight")
        waic_result = waic(idata)
        waic_py_result = ArviZPythonPlots.arviz.waic(idata; pointwise=true)
        py_waic_result = Py(waic_result)
        @test pyconvert(String, py_waic_result.kind) == "waic"
        @test pyconvert(Float64, py_waic_result.elpd) ≈
            pyconvert(Float64, waic_py_result.elpd) rtol = 1e-3
        @test pyconvert(Float64, py_waic_result.se) ≈ pyconvert(Float64, waic_py_result.se) rtol = 1e-1
        @test pyconvert(Float64, py_waic_result.p) ≈ pyconvert(Float64, waic_py_result.p) rtol = 1e-3
        @test pyconvert(Array{Float64}, py_waic_result.elpd_i.values) ≈
            pyconvert(Array{Float64}, waic_py_result.elpd_i.values) rtol = 1e-3
    end
end
