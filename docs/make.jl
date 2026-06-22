using ArviZPythonPlots, Documenter
using ArviZPythonPlots: LazyHelp

include("lazyhelp.jl")

makedocs(;
    modules=[ArviZPythonPlots],
    repo=Remotes.GitHub("arviz-devs", "ArviZPythonPlots.jl"),
    sitename="ArviZPythonPlots.jl",
    pages=[
        "Home" => "index.md",
        "Examples gallery" => [
            "Distribution" => [
                "gallery/distribution/00_plot_dist_ecdf.md",
                "gallery/distribution/01_plot_dist_hist.md",
                "gallery/distribution/02_plot_dist_kde.md",
                "gallery/distribution/03_plot_dist_qds.md",
                "gallery/distribution/04_plot_forest.md",
                "gallery/distribution/05_plot_forest_shade.md",
                "gallery/distribution/06_plot_prior_posterior.md",
                "gallery/distribution/07_plot_pair_focus_distribution.md",
                "gallery/distribution/08_plot_pair_distribution.md",
                "gallery/distribution/08_plot_ridge.md",
                "gallery/distribution/09_plot_dgof.md",
                "gallery/distribution/10_plot_dgof_dist.md",
            ],
            "Posterior comparison" => [
                "gallery/posterior_comparison/00_plot_dist_models.md",
                "gallery/posterior_comparison/01_plot_forest_models.md",
                "gallery/posterior_comparison/02_plot_ridge_multiple.md",
            ],
            "Inference diagnostics" => [
                "gallery/inference_diagnostics/00_plot_rank.md",
                "gallery/inference_diagnostics/01_plot_trace.md",
                "gallery/inference_diagnostics/02_plot_ess_evolution.md",
                "gallery/inference_diagnostics/03_plot_ess_local.md",
                "gallery/inference_diagnostics/04_plot_ess_quantile.md",
                "gallery/inference_diagnostics/05_plot_ess_models.md",
                "gallery/inference_diagnostics/05_plot_mcse.md",
                "gallery/inference_diagnostics/06_plot_convergence_dist.md",
                "gallery/inference_diagnostics/07_plot_autocorr.md",
                "gallery/inference_diagnostics/08_plot_energy.md",
                "gallery/inference_diagnostics/09_plot_pair_focus.md",
                "gallery/inference_diagnostics/10_plot_pair.md",
                "gallery/inference_diagnostics/11_plot_parallel.md",
                "gallery/inference_diagnostics/12_plot_lm.md",
            ],
            "Predictive checks" => [
                "gallery/predictive_checks/00_plot_ppc_dist.md",
                "gallery/predictive_checks/01_plot_ppc_rootogram.md",
                "gallery/predictive_checks/03_plot_pava_calibration.md",
                "gallery/predictive_checks/04_plot_ppc_pit.md",
                "gallery/predictive_checks/05_plot_ppc_coverage.md",
                "gallery/predictive_checks/06_plot_loo_pit.md",
                "gallery/predictive_checks/07_plot_ppc_tstat.md",
                "gallery/predictive_checks/08_plot_ppc_interval.md",
                "gallery/predictive_checks/09_plot_ppc_censored.md",
                "gallery/predictive_checks/10_plot_ppc_pava_residuals.md",
                "gallery/predictive_checks/11_plot_loo_interval.md",
                "gallery/predictive_checks/12_plot_ppc_dist_pit.md",
            ],
            "Prior and likelihood sensitivity checks" => [
                "gallery/prior_and_likelihood_sensitivity_checks/00_plot_psense.md",
                "gallery/prior_and_likelihood_sensitivity_checks/01_plot_psense_quantities.md",
            ],
            "Model comparison" => [
                "gallery/model_comparison/00_plot_compare.md",
                "gallery/model_comparison/01_plot_khat.md",
                "gallery/model_comparison/99_plot_bf.md",
            ],
            "Simulation based calibration" => [
                "gallery/sbc/00_plot_ecdf_pit.md", "gallery/sbc/01_plot_ecdf_coverage.md"
            ],
            "Mixed" => [
                "gallery/mixed/00_plot_rank_dist.md",
                "gallery/mixed/01_plot_trace_dist.md",
                "gallery/mixed/03_combine_plots.md",
            ],
        ],
        "API" => [
            hide("api/index.md"),
            "Plotting styles" => "api/style.md",
            "rcParams" => "api/rcparams.md",
            "Plotting functions" => "api/plots.md",
        ],
    ],
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=haskey(ENV, "CI"),
        sidebar_sitename=false,
        canonical="stable",
        size_threshold=300_000,
    ),
    doctest=false,
    linkcheck=true,
)

deploydocs(;
    repo="github.com/arviz-devs/ArviZPythonPlots.jl.git",
    devbranch="main",
    push_preview=true,
)
