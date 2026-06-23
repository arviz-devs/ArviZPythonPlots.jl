using ArviZExampleData
using ArviZPythonPlots
using DimensionalData
using InferenceObjects
using PosteriorStats
using PythonCall
using Test

@testset "plots" begin
    data = load_example_data("centered_eight")
    data2 = load_example_data("non_centered_eight")

    rng = MersenneTwister(42)
    arr1 = randn(rng, 100, 4)
    arr2 = randn(rng, 100, 4)
    arr3 = randn(rng, 100)

    # binary observed/predicted data, e.g. for calibration-style diagnostics
    prob = rand(rng, 50)
    y = Int.(rand(rng, 50) .< prob)
    y_hat = Int.(rand(rng, 500, 4, 50) .< reshape(prob, 1, 1, :))
    data3 = from_namedtuple(;
        posterior_predictive=(; outcome=y_hat),
        observed_data=(; outcome=y),
        constant_data=(; prob),
    )

    # `data` with an added `log_prior` group, for power-scaling sensitivity diagnostics
    data4 = merge(
        data,
        InferenceData(;
            log_prior=Dataset((
                mu=DimensionalData.rebuild(
                    data.posterior.mu, randn(rng, size(data.posterior.mu))
                ),
                theta=DimensionalData.rebuild(
                    data.posterior.theta, randn(rng, size(data.posterior.theta))
                ),
                tau=DimensionalData.rebuild(
                    data.posterior.tau, randn(rng, size(data.posterior.tau))
                ),
            )),
        ),
    )

    @testset "$(f)" for f in (plot_trace, plot_trace_dist, plot_pair)
        f(data; var_names=["tau", "mu"])
        plotclose()
        f((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "$(f)" for f in (
        plot_autocorr, plot_ess, plot_ess_evolution, plot_mcse, plot_dist, plot_rank
    )
        f(data; var_names=["tau", "mu"])
        plotclose()
        f(arr1)
        plotclose()
        f((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "backend kwarg is not overridden" begin
        pc = plot_dist(data; var_names=["mu"])
        @test pyconvert(String, pc.backend) == "matplotlib"
        plotclose()
        pc = plot_dist(data; var_names=["mu"], backend="none")
        @test pyconvert(String, pc.backend) == "none"
    end

    @testset "plot_rank_dist" begin
        # chain coordinates must start at 0: https://github.com/arviz-devs/arviz-plots/issues
        plot_rank_dist(data; var_names=["tau", "mu"])
        plotclose()
    end

    @testset "$(f)" for f in (plot_energy, plot_parallel)
        f(data)
        plotclose()
    end

    @testset "$(f)" for f in (plot_forest, plot_ridge)
        f(data; var_names=["tau", "mu"])
        plotclose()
        f([(x=arr1,), (x=arr2,)]; var_names=["x"])
        plotclose()
        f((x=arr1, y=arr2); var_names=["x", "y"])
        plotclose()
    end

    @testset "plot_bf" begin
        plot_bf(data, ["mu"])
        plotclose()
    end

    @testset "plot_pair_focus" begin
        plot_pair_focus(data, "mu"; var_names=["theta", "mu"])
        plotclose()
        plot_pair_focus(data, data.posterior.mu; var_names=["theta", "mu"])
        plotclose()
    end

    @testset "plot_lm" begin
        plot_lm(data)
        plotclose()
    end

    @testset "plot_compare" begin
        mc = compare((a=data, b=data2))
        plot_compare(mc)
        plotclose()
    end

    @testset "plot_prior_posterior" begin
        plot_prior_posterior(data; var_names=["mu"])
        plotclose()
    end

    @testset "$(f)" for f in (plot_convergence_dist, plot_dgof, plot_dgof_dist)
        f(data; var_names=["tau", "mu"])
        plotclose()
    end

    @testset "$(f)" for f in (plot_psense_dist, plot_psense_quantities)
        f(data4; prior_var_names=["mu"], likelihood_var_names=["obs"])
        plotclose()
    end

    @testset "plot_khat" begin
        l = loo(data)
        plot_khat(l)
        plotclose()
    end

    @testset "plot_loo_pit" begin
        plot_loo_pit(data; var_names=["obs"])
        plotclose()
    end

    @testset "plot_loo_interval" begin
        plot_loo_interval(data; var_names=["obs"])
        plotclose()
    end

    @testset "$(f)" for f in (
        plot_ppc_censored,
        plot_ppc_dist,
        plot_ppc_interval,
        plot_ppc_pit,
        plot_ppc_tstat,
        plot_ppc_dist_pit,
    )
        f(data; var_names=["obs"])
        plotclose()
    end

    @testset "$(f)" for f in (plot_ppc_rootogram, plot_ppc_pava)
        f(data3; var_names=["outcome"])
        plotclose()
    end

    @testset "plot_ppc_pava_residuals" begin
        plot_ppc_pava_residuals(data3, prob; var_names=["outcome"])
        plotclose()
    end

    @testset "plot_ecdf_pit" begin
        pit = InferenceData(; pit=convert_to_dataset((obs=rand(rng, 8),)))
        plot_ecdf_pit(pit; var_names=["obs"], group="pit")
        plotclose()
    end

    @testset "combine_plots" begin
        combine_plots(data, [(plot_dist, Dict()), (plot_ess, Dict())]; var_names=["mu"])
        plotclose()
    end

    @testset "combine_plots with raw arviz functions" begin
        combine_plots(
            data,
            [
                (ArviZPythonPlots.arviz.plot_dist, Dict()),
                (ArviZPythonPlots.arviz.plot_ess, Dict()),
            ];
            var_names=["mu"],
        )
        plotclose()
    end

    @testset "combine_plots with invalid plot function" begin
        @test_throws ArgumentError combine_plots(data, [(sin, Dict())]; var_names=["mu"])
    end
end
