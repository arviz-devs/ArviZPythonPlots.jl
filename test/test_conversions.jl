@testset "conversions" begin
    @testset "PSISLOOResult" begin
        idata = load_example_data("centered_eight")
        loo_result = loo(idata; reff=1)
        loo_py_result = ArviZ.arviz.loo(idata; pointwise=true, reff=1)
        py_loo_result = ArviZ.topandas(Val(:ELPDData), loo_result)
        @test all(py_loo_result.keys() == loo_py_result.keys())
        @test py_loo_result.elpd_loo ≈ loo_py_result.elpd_loo rtol = 1e-3
        @test py_loo_result.se ≈ loo_py_result.se rtol = 1e-1
        @test py_loo_result.p_loo ≈ loo_py_result.p_loo rtol = 1e-3
        @test py_loo_result.loo_i.values ≈ loo_py_result.loo_i.values rtol = 1e-3
        @test py_loo_result.pareto_k.values ≈ loo_py_result.pareto_k.values rtol = 1e-1
    end
    @testset "WAICResult" begin
        idata = load_example_data("centered_eight")
        waic_result = waic(idata)
        waic_py_result = ArviZ.arviz.waic(idata; pointwise=true)
        py_waic_result = ArviZ.topandas(Val(:ELPDData), waic_result)
        @test all(py_waic_result.keys() == waic_py_result.keys())
        @test py_waic_result.elpd_waic ≈ waic_py_result.elpd_waic rtol = 1e-3
        @test py_waic_result.se ≈ waic_py_result.se rtol = 1e-1
        @test py_waic_result.p_waic ≈ waic_py_result.p_waic rtol = 1e-3
        @test py_waic_result.waic_i.values ≈ waic_py_result.waic_i.values rtol = 1e-3
    end
end
