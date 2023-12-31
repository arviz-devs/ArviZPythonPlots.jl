# Example Gallery

## Autocorrelation Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")
plot_autocorr(data; var_names=["tau", "mu"])
gcf()
```

See [`plot_autocorr`](@ref)

## Bayes Factor Plot

```@example
using ArviZ, ArviZPythonPlots

use_style("arviz-darkgrid")

idata = from_namedtuple((a = 1 .+ randn(5_000) ./ 2,), prior=(a = randn(5_000),))
plot_bf(idata; var_name="a", ref_val=0)
gcf()
```

See [`plot_bf`](@ref)

## Bayesian P-Value Posterior Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("regression1d")
plot_bpv(data)
gcf()
```

See [`plot_bpv`](@ref)

## Bayesian P-Value with Median T Statistic Posterior Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("regression1d")
plot_bpv(data; kind="t_stat", t_stat="0.5")
gcf()
```

See [`plot_bpv`](@ref)

## Compare Plot

```@example
using ArviZ, ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

model_compare = compare(
    (
        var"Centered 8 schools" = load_example_data("centered_eight"),
        var"Non-centered 8 schools" = load_example_data("non_centered_eight"),
    ),
)
plot_compare(model_compare; figsize=(12, 4))
gcf()
```

See [`compare`](https://julia.arviz.org/ArviZ/stable/api/stats/#ArviZ.compare), [`plot_compare`](@ref)

## Density Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

centered_data = load_example_data("centered_eight")
non_centered_data = load_example_data("non_centered_eight")
plot_density(
    [centered_data, non_centered_data];
    data_labels=["Centered", "Non Centered"],
    var_names=["theta"],
    shade=0.1,
)
gcf()
```

See [`plot_density`](@ref)

## Dist Plot

```@example
using ArviZPythonPlots, Distributions, Random

Random.seed!(308)

use_style("arviz-darkgrid")

a = rand(Poisson(4), 1000)
b = rand(Normal(0, 1), 1000)
_, ax = subplots(1, 2; figsize=(10, 4))
plot_dist(a; color="C1", label="Poisson", ax=ax[0])
plot_dist(b; color="C2", label="Gaussian", ax=ax[1])
gcf()
```

See [`plot_dist`](@ref)

## Dot Plot

```@example
using ArviZPythonPlots

use_style("arviz-darkgrid")

data = randn(1000)
figure() # hide
plot_dot(data; dotcolor="C1", point_interval=true)
title("Gaussian Distribution")
gcf()
```

See [`plot_dot`](@ref)

## ECDF Plot

```@example
using ArviZPythonPlots, Distributions

use_style("arviz-darkgrid")

sample = randn(1_000)
dist = Normal()
plot_ecdf(sample; cdf=x -> cdf(dist, x), confidence_bands=true)
gcf()
```

See [`plot_ecdf`](@ref)

## ELPD Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

d1 = load_example_data("centered_eight")
d2 = load_example_data("non_centered_eight")
plot_elpd(Dict("Centered eight" => d1, "Non centered eight" => d2); xlabels=true)
gcf()
```

See [`plot_elpd`](@ref)

## Energy Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")
plot_energy(data; figsize=(12, 8))
gcf()
```

See [`plot_energy`](@ref)

## ESS Evolution Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

idata = load_example_data("radon")
plot_ess(idata; var_names=["b"], kind="evolution")
gcf()
```

See [`plot_ess`](@ref)

## ESS Local Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

idata = load_example_data("non_centered_eight")
plot_ess(idata; var_names=["mu"], kind="local", marker="_", ms=20, mew=2, rug=true)
gcf()
```

See [`plot_ess`](@ref)

## ESS Quantile Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

idata = load_example_data("radon")
plot_ess(idata; var_names=["sigma"], kind="quantile", color="C4")
gcf()
```

See [`plot_ess`](@ref)

## Forest Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

centered_data = load_example_data("centered_eight")
non_centered_data = load_example_data("non_centered_eight")
plot_forest(
    [centered_data, non_centered_data];
    model_names=["Centered", "Non Centered"],
    var_names=["mu"],
)
title("Estimated theta for eight schools model")
gcf()
```

See [`plot_forest`](@ref)

## Ridge Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

rugby_data = load_example_data("rugby")
plot_forest(
    rugby_data;
    kind="ridgeplot",
    var_names=["defs"],
    linewidth=4,
    combined=true,
    ridgeplot_overlap=1.5,
    colors="blue",
    figsize=(9, 4),
)
title("Relative defensive strength\nof Six Nation rugby teams")
gcf()
```

See [`plot_forest`](@ref)

## Plot HDI

```@example
using Random
using ArviZPythonPlots

Random.seed!(308)

use_style("arviz-darkgrid")

x_data = randn(100)
y_data = 2 .+ x_data .* 0.5
y_data_rep = 0.5 .* randn(200, 100) .+ transpose(y_data)

plot(x_data, y_data; color="C6")
plot_hdi(x_data, y_data_rep; color="k", plot_kwargs=Dict("ls" => "--"))
gcf()
```

See [`plot_hdi`](@ref)

## Joint Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("non_centered_eight")
plot_pair(
    data;
    var_names=["theta"],
    coords=Dict("school" => ["Choate", "Phillips Andover"]),
    kind="hexbin",
    marginals=true,
    figsize=(10, 10),
)
gcf()
```

See [`plot_pair`](@ref)

## KDE Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")

## Combine different posterior draws from different chains
obs = data.posterior_predictive.obs
size_obs = size(obs)
y_hat = reshape(obs, prod(size_obs[1:2]), size_obs[3:end]...)

plot_kde(
    y_hat;
    label="Estimated Effect\n of SAT Prep",
    rug=true,
    plot_kwargs=Dict("linewidth" => 2, "color" => "black"),
    rug_kwargs=Dict("color" => "black"),
)
gcf()
```

See [`plot_kde`](@ref)

## 2d KDE

```@example
using Random
using ArviZPythonPlots

Random.seed!(308)

use_style("arviz-darkgrid")

plot_kde(rand(100), rand(100))
gcf()
```

See [`plot_kde`](@ref)

## KDE Quantiles Plot

```@example
using Random
using Distributions
using ArviZPythonPlots

Random.seed!(308)

use_style("arviz-darkgrid")

dist = rand(Beta(rand(Uniform(0.5, 10)), 5), 1000)
plot_kde(dist; quantiles=[0.25, 0.5, 0.75])
gcf()
```

See [`plot_kde`](@ref)

## Pareto Shape Plot

```@example
using ArviZ, ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

idata = load_example_data("radon")
loo_data = loo(idata)
plot_khat(loo_data; show_bins=true)
gcf()
```

See [`loo`](https://julia.arviz.org/ArviZ/stable/api/stats/#ArviZ.loo), [`plot_khat`](@ref)

## LOO-PIT ECDF Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

idata = load_example_data("radon")

plot_loo_pit(idata; y="y", ecdf=true, color="maroon")
gcf()
```

See [`loo_pit`](https://julia.arviz.org/ArviZ/stable/api/stats/#ArviZ.loo_pit), [`plot_loo_pit`](@ref)

## LOO-PIT Overlay Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

idata = load_example_data("non_centered_eight")
plot_loo_pit(; idata, y="obs", color="indigo")
gcf()
```

See [`loo_pit`](https://julia.arviz.org/ArviZ/stable/api/stats/#ArviZ.loo_pit), [`plot_loo_pit`](@ref)

## Quantile Monte Carlo Standard Error Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")
plot_mcse(data; var_names=["tau", "mu"], rug=true, extra_methods=true)
gcf()
```

See [`plot_mcse`](@ref)

## Quantile MCSE Errobar Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("radon")
plot_mcse(data; var_names=["sigma_a"], color="C4", errorbar=true)
gcf()
```

See [`plot_mcse`](@ref)

## Pair Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

centered = load_example_data("centered_eight")
coords = Dict("school" => ["Choate", "Deerfield"])
plot_pair(
    centered; var_names=["theta", "mu", "tau"], coords, divergences=true, textsize=22
)
gcf()
```

See [`plot_pair`](@ref)

## Hexbin Pair Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

centered = load_example_data("centered_eight")
coords = Dict("school" => ["Choate", "Deerfield"])
plot_pair(
    centered;
    var_names=["theta", "mu", "tau"],
    kind="hexbin",
    coords,
    colorbar=true,
    divergences=true,
)
gcf()
```

See [`plot_pair`](@ref)

## KDE Pair Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

centered = load_example_data("centered_eight")
coords = Dict("school" => ["Choate", "Deerfield"])
plot_pair(
    centered;
    var_names=["theta", "mu", "tau"],
    kind="kde",
    coords,
    divergences=true,
    textsize=22,
)
gcf()
```

See [`plot_pair`](@ref)

## Point Estimate Pair Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

centered = load_example_data("centered_eight")
coords = Dict("school" => ["Choate", "Deerfield"])
plot_pair(
    centered;
    var_names=["mu", "theta"],
    kind=["scatter", "kde"],
    kde_kwargs=Dict("fill_last" => false),
    marginals=true,
    coords,
    point_estimate="median",
    figsize=(10, 8),
)
gcf()
```

See [`plot_pair`](@ref)

## Parallel Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")
ax = plot_parallel(data; var_names=["theta", "tau", "mu"])
ax.set_xticklabels(ax.get_xticklabels(); rotation=70)
draw()
gcf()
```

See [`plot_parallel`](@ref)

## Posterior Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")
coords = Dict("school" => ["Choate"])
plot_posterior(data; var_names=["mu", "theta"], coords, rope=(-1, 1))
gcf()
```

See [`plot_posterior`](@ref)

## Posterior Predictive Check Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("non_centered_eight")
plot_ppc(data; data_pairs=Dict("obs" => "obs"), alpha=0.03, figsize=(12, 6), textsize=14)
gcf()
```

See [`plot_ppc`](@ref)

## Posterior Predictive Check Cumulative Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("non_centered_eight")
plot_ppc(data; alpha=0.3, kind="cumulative", figsize=(12, 6), textsize=14)
gcf()
```

See [`plot_ppc`](@ref)

## Rank Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("centered_eight")
plot_rank(data; var_names=["tau", "mu"])
gcf()
```

See [`plot_rank`](@ref)

## Regression Plot

```@example
using ArviZ, ArviZPythonPlots, ArviZExampleData, DimensionalData

use_style("arviz-darkgrid")

data = load_example_data("regression1d")
x = range(0, 1; length=100)
posterior = data.posterior
constant_data = convert_to_dataset((; x); default_dims=())
y_model = broadcast_dims(muladd, posterior.intercept, posterior.slope, constant_data.x)
posterior = merge(posterior, (; y_model))
data = merge(data, InferenceData(; posterior, constant_data))
plot_lm("y"; idata=data, x="x", y_model="y_model")
gcf()
```

See [`plot_lm`](@ref)

## Separation Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("classification10d")
plot_separation(data; y="outcome", y_hat="outcome", figsize=(8, 1))
gcf()
```

See [`plot_separation`](@ref)

## Trace Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("non_centered_eight")
plot_trace(data; var_names=["tau", "mu"])
gcf()
```

See [`plot_trace`](@ref)

## Violin Plot

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-darkgrid")

data = load_example_data("non_centered_eight")
plot_violin(data; var_names=["mu", "tau"])
gcf()
```

See [`plot_violin`](@ref)

## Styles

```@example
using ArviZPythonPlots, Distributions, PythonCall

x = range(0, 1; length=100)
dist = pdf.(Beta(2, 5), x)

style_list = [
    "default",
    ["default", "arviz-colors"],
    "arviz-darkgrid",
    "arviz-whitegrid",
    "arviz-white",
    "arviz-grayscale",
    ["arviz-white", "arviz-redish"],
    ["arviz-white", "arviz-bluish"],
    ["arviz-white", "arviz-orangish"],
    ["arviz-white", "arviz-brownish"],
    ["arviz-white", "arviz-purplish"],
    ["arviz-white", "arviz-cyanish"],
    ["arviz-white", "arviz-greenish"],
    ["arviz-white", "arviz-royish"],
    ["arviz-white", "arviz-viridish"],
    ["arviz-white", "arviz-plasmish"],
    "arviz-doc",
    "arviz-docgrid",
]

fig = figure(; figsize=(20, 10))
for (idx, style) in enumerate(style_list)
    pywith(pyplot.style.context(style; after_reset=true)) do _
        ax = fig.add_subplot(5, 4, idx; label=idx)
        colors = pyplot.rcParams["axes.prop_cycle"].by_key()["color"]
        for i in 0:(length(colors) - 1)
            ax.plot(x, dist .- i, "C$i"; label="C$i")
        end
        ax.set_title(style)
        ax.set_xlabel("x")
        ax.set_ylabel("f(x)"; rotation=0, labelpad=15)
        ax.set_xticklabels([])
    end
end
tight_layout()
gcf()
```
