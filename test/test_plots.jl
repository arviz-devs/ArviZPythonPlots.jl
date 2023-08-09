using ArviZ
using ArviZExampleData
using ArviZPythonPlots
using PythonCall
using Test

@testset "plots" begin
    data = load_example_data("centered_eight")
    data2 = load_example_data("non_centered_eight")

    rng = MersenneTwister(42)
    arr1 = randn(rng, 100, 4)
    arr2 = randn(rng, 100, 4)
    arr3 = randn(rng, 100)

    @testset "$(f)" for f in (plot_trace, plot_pair)
        f(data; var_names=["tau", "mu"])
        plotclose()
        f((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "$(f)" for f in
                        (plot_autocorr, plot_ess, plot_mcse, plot_posterior, plot_violin)
        f(data; var_names=["tau", "mu"])
        plotclose()
        f(arr1)
        plotclose()
        f((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "$(f)" for f in (plot_energy, plot_parallel)
        f(data)
        plotclose()
    end

    @testset "$(f)" for f in (plot_density, plot_forest)
        f(data; var_names=["tau", "mu"])
        plotclose()
        f([(x=arr1,), (x=arr2,)]; var_names=["x"])
        plotclose()
        f(arr3)
        plotclose()
        f((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "plot_bpv" begin
        plot_bpv(data)
        plotclose()
        plot_bpv(data; kind="p_value")
        plotclose()
    end

    @testset "plot_separation" begin
        data3 = load_example_data("classification10d")
        plot_separation(data3; y="outcome")
        plotclose()
    end

    @testset "plot_rank" begin
        plot_rank(data; var_names=["tau", "mu"])
        plotclose()
        plot_rank(arr1)
        plotclose()
        plot_rank((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "plot_compare" begin
        mc = compare((a=data, b=data2))
        plot_compare(mc)
        plotclose()
    end

    @testset "plot_dist_compare" begin
        plot_dist_comparison(data; var_names=["mu"])
        plotclose()
    end

    @testset "$(f)" for f in (plot_dist, ArviZPythonPlots.plot_ecdf)
        f(arr1)
        plotclose()
    end

    VERSION ≥ v"1.8" && @testset "plot_kde" begin
        plot_kde(arr1)
        plotclose()

        plot_kde(arr1, arr2)
        plotclose()
    end

    @testset "plot_hdi" begin
        x_data = randn(rng, 100)
        y_data = 2 .+ x_data .* 0.5
        y_data_rep = 0.5 .* randn(rng, 200, 100) .+ transpose(y_data)
        plot_hdi(x_data, y_data_rep)
        plotclose()
    end

    @testset "plot_elpd" begin
        plot_elpd(Dict("a" => data, "b" => data2))
        plotclose()
        plot_elpd(Dict("a" => loo(data), "b" => loo(data2)))
        plotclose()
    end

    @testset "plot_khat" begin
        l = loo(data)
        plot_khat(l)
        plotclose()
    end

    @testset "plot_loo_pit" begin
        plot_loo_pit(data; y="obs")
        plotclose()
    end

    @testset "plot_loo_pit" begin
        plot_ppc(data)
        plotclose()
    end
end
