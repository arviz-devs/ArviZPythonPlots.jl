var documenterSearchIndex = {"docs":
[{"location":"api/rcparams/#rcparams-api","page":"rcParams","title":"rcParams","text":"","category":"section"},{"location":"api/rcparams/","page":"rcParams","title":"rcParams","text":"Pages = [\"rcparams.md\"]","category":"page"},{"location":"api/rcparams/#Reference","page":"rcParams","title":"Reference","text":"","category":"section"},{"location":"api/rcparams/","page":"rcParams","title":"rcParams","text":"Modules = [ArviZPythonPlots]\nPages   = [\"rcparams.jl\"]\nPrivate = false","category":"page"},{"location":"api/rcparams/#ArviZPythonPlots.rcParams","page":"rcParams","title":"ArviZPythonPlots.rcParams","text":"\n\n","category":"constant"},{"location":"api/rcparams/#ArviZPythonPlots.rc_context-Tuple","page":"rcParams","title":"ArviZPythonPlots.rc_context","text":"\n\n","category":"method"},{"location":"api/#api","page":"API Overview","title":"API Overview","text":"","category":"section"},{"location":"api/","page":"API Overview","title":"API Overview","text":"Pages = [\"style.md\", \"rcparams.md\", \"plots.md\"]\nDepth = 1","category":"page"},{"location":"examples/#Example-Gallery","page":"Examples gallery","title":"Example Gallery","text":"","category":"section"},{"location":"examples/#Autocorrelation-Plot","page":"Examples gallery","title":"Autocorrelation Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\nplot_autocorr(data; var_names=[\"tau\", \"mu\"])\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_autocorr","category":"page"},{"location":"examples/#Bayes-Factor-Plot","page":"Examples gallery","title":"Bayes Factor Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZ, ArviZPythonPlots\n\nuse_style(\"arviz-darkgrid\")\n\nidata = from_namedtuple((a = 1 .+ randn(5_000) ./ 2,), prior=(a = randn(5_000),))\nplot_bf(idata; var_name=\"a\", ref_val=0)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_bf","category":"page"},{"location":"examples/#Bayesian-P-Value-Posterior-Plot","page":"Examples gallery","title":"Bayesian P-Value Posterior Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"regression1d\")\nplot_bpv(data)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_bpv","category":"page"},{"location":"examples/#Bayesian-P-Value-with-Median-T-Statistic-Posterior-Plot","page":"Examples gallery","title":"Bayesian P-Value with Median T Statistic Posterior Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"regression1d\")\nplot_bpv(data; kind=\"t_stat\", t_stat=\"0.5\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_bpv","category":"page"},{"location":"examples/#Compare-Plot","page":"Examples gallery","title":"Compare Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZ, ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nmodel_compare = compare(\n    (\n        var\"Centered 8 schools\" = load_example_data(\"centered_eight\"),\n        var\"Non-centered 8 schools\" = load_example_data(\"non_centered_eight\"),\n    ),\n)\nplot_compare(model_compare; figsize=(12, 4))\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See compare, plot_compare","category":"page"},{"location":"examples/#Density-Plot","page":"Examples gallery","title":"Density Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ncentered_data = load_example_data(\"centered_eight\")\nnon_centered_data = load_example_data(\"non_centered_eight\")\nplot_density(\n    [centered_data, non_centered_data];\n    data_labels=[\"Centered\", \"Non Centered\"],\n    var_names=[\"theta\"],\n    shade=0.1,\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_density","category":"page"},{"location":"examples/#Dist-Plot","page":"Examples gallery","title":"Dist Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, Distributions, Random\n\nRandom.seed!(308)\n\nuse_style(\"arviz-darkgrid\")\n\na = rand(Poisson(4), 1000)\nb = rand(Normal(0, 1), 1000)\n_, ax = subplots(1, 2; figsize=(10, 4))\nplot_dist(a; color=\"C1\", label=\"Poisson\", ax=ax[0])\nplot_dist(b; color=\"C2\", label=\"Gaussian\", ax=ax[1])\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_dist","category":"page"},{"location":"examples/#Dot-Plot","page":"Examples gallery","title":"Dot Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots\n\nuse_style(\"arviz-darkgrid\")\n\ndata = randn(1000)\nfigure() # hide\nplot_dot(data; dotcolor=\"C1\", point_interval=true)\ntitle(\"Gaussian Distribution\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_dot","category":"page"},{"location":"examples/#ECDF-Plot","page":"Examples gallery","title":"ECDF Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, Distributions\n\nuse_style(\"arviz-darkgrid\")\n\nsample = randn(1_000)\ndist = Normal()\nplot_ecdf(sample; cdf=x -> cdf(dist, x), confidence_bands=true)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_ecdf","category":"page"},{"location":"examples/#ELPD-Plot","page":"Examples gallery","title":"ELPD Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nd1 = load_example_data(\"centered_eight\")\nd2 = load_example_data(\"non_centered_eight\")\nplot_elpd(Dict(\"Centered eight\" => d1, \"Non centered eight\" => d2); xlabels=true)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_elpd","category":"page"},{"location":"examples/#Energy-Plot","page":"Examples gallery","title":"Energy Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\nplot_energy(data; figsize=(12, 8))\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_energy","category":"page"},{"location":"examples/#ESS-Evolution-Plot","page":"Examples gallery","title":"ESS Evolution Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nidata = load_example_data(\"radon\")\nplot_ess(idata; var_names=[\"b\"], kind=\"evolution\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_ess","category":"page"},{"location":"examples/#ESS-Local-Plot","page":"Examples gallery","title":"ESS Local Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nidata = load_example_data(\"non_centered_eight\")\nplot_ess(idata; var_names=[\"mu\"], kind=\"local\", marker=\"_\", ms=20, mew=2, rug=true)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_ess","category":"page"},{"location":"examples/#ESS-Quantile-Plot","page":"Examples gallery","title":"ESS Quantile Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nidata = load_example_data(\"radon\")\nplot_ess(idata; var_names=[\"sigma\"], kind=\"quantile\", color=\"C4\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_ess","category":"page"},{"location":"examples/#Forest-Plot","page":"Examples gallery","title":"Forest Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ncentered_data = load_example_data(\"centered_eight\")\nnon_centered_data = load_example_data(\"non_centered_eight\")\nplot_forest(\n    [centered_data, non_centered_data];\n    model_names=[\"Centered\", \"Non Centered\"],\n    var_names=[\"mu\"],\n)\ntitle(\"Estimated theta for eight schools model\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_forest","category":"page"},{"location":"examples/#Ridge-Plot","page":"Examples gallery","title":"Ridge Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nrugby_data = load_example_data(\"rugby\")\nplot_forest(\n    rugby_data;\n    kind=\"ridgeplot\",\n    var_names=[\"defs\"],\n    linewidth=4,\n    combined=true,\n    ridgeplot_overlap=1.5,\n    colors=\"blue\",\n    figsize=(9, 4),\n)\ntitle(\"Relative defensive strength\\nof Six Nation rugby teams\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_forest","category":"page"},{"location":"examples/#Plot-HDI","page":"Examples gallery","title":"Plot HDI","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using Random\nusing ArviZPythonPlots\n\nRandom.seed!(308)\n\nuse_style(\"arviz-darkgrid\")\n\nx_data = randn(100)\ny_data = 2 .+ x_data .* 0.5\ny_data_rep = 0.5 .* randn(200, 100) .+ transpose(y_data)\n\nplot(x_data, y_data; color=\"C6\")\nplot_hdi(x_data, y_data_rep; color=\"k\", plot_kwargs=Dict(\"ls\" => \"--\"))\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_hdi","category":"page"},{"location":"examples/#Joint-Plot","page":"Examples gallery","title":"Joint Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"non_centered_eight\")\nplot_pair(\n    data;\n    var_names=[\"theta\"],\n    coords=Dict(\"school\" => [\"Choate\", \"Phillips Andover\"]),\n    kind=\"hexbin\",\n    marginals=true,\n    figsize=(10, 10),\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_pair","category":"page"},{"location":"examples/#KDE-Plot","page":"Examples gallery","title":"KDE Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\n\n## Combine different posterior draws from different chains\nobs = data.posterior_predictive.obs\nsize_obs = size(obs)\ny_hat = reshape(obs, prod(size_obs[1:2]), size_obs[3:end]...)\n\nplot_kde(\n    y_hat;\n    label=\"Estimated Effect\\n of SAT Prep\",\n    rug=true,\n    plot_kwargs=Dict(\"linewidth\" => 2, \"color\" => \"black\"),\n    rug_kwargs=Dict(\"color\" => \"black\"),\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_kde","category":"page"},{"location":"examples/#d-KDE","page":"Examples gallery","title":"2d KDE","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using Random\nusing ArviZPythonPlots\n\nRandom.seed!(308)\n\nuse_style(\"arviz-darkgrid\")\n\nplot_kde(rand(100), rand(100))\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_kde","category":"page"},{"location":"examples/#KDE-Quantiles-Plot","page":"Examples gallery","title":"KDE Quantiles Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using Random\nusing Distributions\nusing ArviZPythonPlots\n\nRandom.seed!(308)\n\nuse_style(\"arviz-darkgrid\")\n\ndist = rand(Beta(rand(Uniform(0.5, 10)), 5), 1000)\nplot_kde(dist; quantiles=[0.25, 0.5, 0.75])\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_kde","category":"page"},{"location":"examples/#Pareto-Shape-Plot","page":"Examples gallery","title":"Pareto Shape Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZ, ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nidata = load_example_data(\"radon\")\nloo_data = loo(idata)\nplot_khat(loo_data; show_bins=true)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See loo, plot_khat","category":"page"},{"location":"examples/#LOO-PIT-ECDF-Plot","page":"Examples gallery","title":"LOO-PIT ECDF Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nidata = load_example_data(\"radon\")\n\nplot_loo_pit(idata; y=\"y\", ecdf=true, color=\"maroon\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See loo_pit, plot_loo_pit","category":"page"},{"location":"examples/#LOO-PIT-Overlay-Plot","page":"Examples gallery","title":"LOO-PIT Overlay Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\nidata = load_example_data(\"non_centered_eight\")\nplot_loo_pit(; idata, y=\"obs\", color=\"indigo\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See loo_pit, plot_loo_pit","category":"page"},{"location":"examples/#Quantile-Monte-Carlo-Standard-Error-Plot","page":"Examples gallery","title":"Quantile Monte Carlo Standard Error Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\nplot_mcse(data; var_names=[\"tau\", \"mu\"], rug=true, extra_methods=true)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_mcse","category":"page"},{"location":"examples/#Quantile-MCSE-Errobar-Plot","page":"Examples gallery","title":"Quantile MCSE Errobar Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"radon\")\nplot_mcse(data; var_names=[\"sigma_a\"], color=\"C4\", errorbar=true)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_mcse","category":"page"},{"location":"examples/#Pair-Plot","page":"Examples gallery","title":"Pair Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ncentered = load_example_data(\"centered_eight\")\ncoords = Dict(\"school\" => [\"Choate\", \"Deerfield\"])\nplot_pair(\n    centered; var_names=[\"theta\", \"mu\", \"tau\"], coords, divergences=true, textsize=22\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_pair","category":"page"},{"location":"examples/#Hexbin-Pair-Plot","page":"Examples gallery","title":"Hexbin Pair Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ncentered = load_example_data(\"centered_eight\")\ncoords = Dict(\"school\" => [\"Choate\", \"Deerfield\"])\nplot_pair(\n    centered;\n    var_names=[\"theta\", \"mu\", \"tau\"],\n    kind=\"hexbin\",\n    coords,\n    colorbar=true,\n    divergences=true,\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_pair","category":"page"},{"location":"examples/#KDE-Pair-Plot","page":"Examples gallery","title":"KDE Pair Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ncentered = load_example_data(\"centered_eight\")\ncoords = Dict(\"school\" => [\"Choate\", \"Deerfield\"])\nplot_pair(\n    centered;\n    var_names=[\"theta\", \"mu\", \"tau\"],\n    kind=\"kde\",\n    coords,\n    divergences=true,\n    textsize=22,\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_pair","category":"page"},{"location":"examples/#Point-Estimate-Pair-Plot","page":"Examples gallery","title":"Point Estimate Pair Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ncentered = load_example_data(\"centered_eight\")\ncoords = Dict(\"school\" => [\"Choate\", \"Deerfield\"])\nplot_pair(\n    centered;\n    var_names=[\"mu\", \"theta\"],\n    kind=[\"scatter\", \"kde\"],\n    kde_kwargs=Dict(\"fill_last\" => false),\n    marginals=true,\n    coords,\n    point_estimate=\"median\",\n    figsize=(10, 8),\n)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_pair","category":"page"},{"location":"examples/#Parallel-Plot","page":"Examples gallery","title":"Parallel Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\nax = plot_parallel(data; var_names=[\"theta\", \"tau\", \"mu\"])\nax.set_xticklabels(ax.get_xticklabels(); rotation=70)\ndraw()\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_parallel","category":"page"},{"location":"examples/#Posterior-Plot","page":"Examples gallery","title":"Posterior Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\ncoords = Dict(\"school\" => [\"Choate\"])\nplot_posterior(data; var_names=[\"mu\", \"theta\"], coords, rope=(-1, 1))\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_posterior","category":"page"},{"location":"examples/#Posterior-Predictive-Check-Plot","page":"Examples gallery","title":"Posterior Predictive Check Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"non_centered_eight\")\nplot_ppc(data; data_pairs=Dict(\"obs\" => \"obs\"), alpha=0.03, figsize=(12, 6), textsize=14)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_ppc","category":"page"},{"location":"examples/#Posterior-Predictive-Check-Cumulative-Plot","page":"Examples gallery","title":"Posterior Predictive Check Cumulative Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"non_centered_eight\")\nplot_ppc(data; alpha=0.3, kind=\"cumulative\", figsize=(12, 6), textsize=14)\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_ppc","category":"page"},{"location":"examples/#Rank-Plot","page":"Examples gallery","title":"Rank Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"centered_eight\")\nplot_rank(data; var_names=[\"tau\", \"mu\"])\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_rank","category":"page"},{"location":"examples/#Regression-Plot","page":"Examples gallery","title":"Regression Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZ, ArviZPythonPlots, ArviZExampleData, DimensionalData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"regression1d\")\nx = range(0, 1; length=100)\nposterior = data.posterior\nconstant_data = convert_to_dataset((; x); default_dims=())\ny_model = broadcast_dims(muladd, posterior.intercept, posterior.slope, constant_data.x)\nposterior = merge(posterior, (; y_model))\ndata = merge(data, InferenceData(; posterior, constant_data))\nplot_lm(\"y\"; idata=data, x=\"x\", y_model=\"y_model\")\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_lm","category":"page"},{"location":"examples/#Separation-Plot","page":"Examples gallery","title":"Separation Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"classification10d\")\nplot_separation(data; y=\"outcome\", y_hat=\"outcome\", figsize=(8, 1))\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_separation","category":"page"},{"location":"examples/#Trace-Plot","page":"Examples gallery","title":"Trace Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"non_centered_eight\")\nplot_trace(data; var_names=[\"tau\", \"mu\"])\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_trace","category":"page"},{"location":"examples/#Violin-Plot","page":"Examples gallery","title":"Violin Plot","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, ArviZExampleData\n\nuse_style(\"arviz-darkgrid\")\n\ndata = load_example_data(\"non_centered_eight\")\nplot_violin(data; var_names=[\"mu\", \"tau\"])\ngcf()","category":"page"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"See plot_violin","category":"page"},{"location":"examples/#Styles","page":"Examples gallery","title":"Styles","text":"","category":"section"},{"location":"examples/","page":"Examples gallery","title":"Examples gallery","text":"using ArviZPythonPlots, Distributions, PythonCall\n\nx = range(0, 1; length=100)\ndist = pdf.(Beta(2, 5), x)\n\nstyle_list = [\n    \"default\",\n    [\"default\", \"arviz-colors\"],\n    \"arviz-darkgrid\",\n    \"arviz-whitegrid\",\n    \"arviz-white\",\n    \"arviz-grayscale\",\n    [\"arviz-white\", \"arviz-redish\"],\n    [\"arviz-white\", \"arviz-bluish\"],\n    [\"arviz-white\", \"arviz-orangish\"],\n    [\"arviz-white\", \"arviz-brownish\"],\n    [\"arviz-white\", \"arviz-purplish\"],\n    [\"arviz-white\", \"arviz-cyanish\"],\n    [\"arviz-white\", \"arviz-greenish\"],\n    [\"arviz-white\", \"arviz-royish\"],\n    [\"arviz-white\", \"arviz-viridish\"],\n    [\"arviz-white\", \"arviz-plasmish\"],\n    \"arviz-doc\",\n    \"arviz-docgrid\",\n]\n\nfig = figure(; figsize=(20, 10))\nfor (idx, style) in enumerate(style_list)\n    pywith(pyplot.style.context(style; after_reset=true)) do _\n        ax = fig.add_subplot(5, 4, idx; label=idx)\n        colors = pyplot.rcParams[\"axes.prop_cycle\"].by_key()[\"color\"]\n        for i in 0:(length(colors) - 1)\n            ax.plot(x, dist .- i, \"C$i\"; label=\"C$i\")\n        end\n        ax.set_title(style)\n        ax.set_xlabel(\"x\")\n        ax.set_ylabel(\"f(x)\"; rotation=0, labelpad=15)\n        ax.set_xticklabels([])\n    end\nend\ntight_layout()\ngcf()","category":"page"},{"location":"api/style/#style-api","page":"Plotting styles","title":"Plotting styles","text":"","category":"section"},{"location":"api/style/","page":"Plotting styles","title":"Plotting styles","text":"Pages = [\"style.md\"]","category":"page"},{"location":"api/style/#Reference","page":"Plotting styles","title":"Reference","text":"","category":"section"},{"location":"api/style/","page":"Plotting styles","title":"Plotting styles","text":"Modules = [ArviZPythonPlots]\nPages   = [\"style.jl\"]\nPrivate = false","category":"page"},{"location":"api/style/#ArviZPythonPlots.styles-Tuple{}","page":"Plotting styles","title":"ArviZPythonPlots.styles","text":"styles() -> Vector{String}\n\nGet all available matplotlib styles for use with use_style\n\n\n\n\n\n","category":"method"},{"location":"api/style/#ArviZPythonPlots.use_style-Tuple{Any}","page":"Plotting styles","title":"ArviZPythonPlots.use_style","text":"use_style(style::String)\nuse_style(style::Vector{String})\n\nUse matplotlib style settings from a style specification style.\n\nThe style name of \"default\" is reserved for reverting back to the default style settings.\n\nArviZ-specific styles include [\"arviz-whitegrid\", \"arviz-darkgrid\", \"arviz-colors\", \"arviz-white\", \"arviz-doc\"]. To see all available style specifications, use styles().\n\nIf a Vector of styles is provided, they are applied from first to last.\n\n\n\n\n\n","category":"method"},{"location":"#ArviZPythonPlots.jl","page":"Home","title":"ArviZPythonPlots.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"ArviZPythonPlots.jl provides PyPlot-compatible plotting functions for exploratory analysis of Bayesian models using ArviZ.jl. It uses PythonCall.jl to provide an interface for using the plotting functions in Python ArviZ with Julia types. It also re-exports all methods exported by PythonPlot.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"For details, see the Example Gallery or the API.","category":"page"},{"location":"#installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install ArviZPythonPlots.jl, we first need to install Python ArviZ. From the Julia REPL, type ] to enter the Pkg REPL mode and run","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add ArviZPythonPlots","category":"page"},{"location":"api/plots/#plots-api","page":"Plotting functions","title":"Plotting functions","text":"","category":"section"},{"location":"api/plots/","page":"Plotting functions","title":"Plotting functions","text":"Pages = [\"plots.md\"]","category":"page"},{"location":"api/plots/#Reference","page":"Plotting functions","title":"Reference","text":"","category":"section"},{"location":"api/plots/","page":"Plotting functions","title":"Plotting functions","text":"Modules = [ArviZPythonPlots]\nPages   = [\"plots.jl\"]\nPrivate = false","category":"page"},{"location":"api/plots/#ArviZPythonPlots.plot_autocorr-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_autocorr","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_bf-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_bf","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_bpv-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_bpv","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_compare-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_compare","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_density-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_density","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_dist-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_dist","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_dist_comparison-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_dist_comparison","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_dot-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_dot","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_ecdf-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_ecdf","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_elpd-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_elpd","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_energy-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_energy","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_ess-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_ess","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_forest-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_forest","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_hdi-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_hdi","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_kde-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_kde","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_khat-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_khat","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_lm-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_lm","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_loo_pit-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_loo_pit","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_mcse-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_mcse","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_pair-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_pair","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_parallel-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_parallel","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_posterior-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_posterior","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_ppc-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_ppc","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_rank-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_rank","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_separation-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_separation","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_trace-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_trace","text":"\n\n","category":"method"},{"location":"api/plots/#ArviZPythonPlots.plot_violin-Tuple","page":"Plotting functions","title":"ArviZPythonPlots.plot_violin","text":"\n\n","category":"method"}]
}
