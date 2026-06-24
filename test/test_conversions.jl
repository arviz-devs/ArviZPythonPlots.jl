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

    @testset "ModelComparisonResult" begin
        data = load_example_data("centered_eight")
        data2 = load_example_data("non_centered_eight")
        mc = compare((a=data, b=data2))
        pdf = Py(mc)
        columns = pyconvert(Vector{String}, pdf.columns.to_list())
        # not computed by `PosteriorStats.compare`, but required by `plot_compare`, which
        # expects the same columns as `arviz_stats.compare`
        @test all(in(columns), ("p_worse", "diag_diff", "diag_elpd"))
        @test all(isnan, pyconvert(Vector{Float64}, pdf.p_worse.to_numpy()))
        @test all(==(""), pyconvert(Vector{String}, pdf.diag_diff.to_numpy()))
        @test all(==(""), pyconvert(Vector{String}, pdf.diag_elpd.to_numpy()))
    end
end
