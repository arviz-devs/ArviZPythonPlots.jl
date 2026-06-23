# ---
# title: "Interval plot (LOO)"
# id: 11_plot_loo_interval
# cover: assets/11_plot_loo_interval.png
# description: "Plot LOO posterior predictive point estimate and intervals at each observation."
# ---
#
# # Interval plot (LOO)
#
# Plot LOO posterior predictive point estimate and intervals at each observation.

using ArviZPythonPlots, ArviZExampleData, DimensionalData, InferenceObjects

use_style("arviz-variat")

data = load_example_data("radon")
obs_id_subset = At(0:49)
data_subset = InferenceData(;
    posterior_predictive=data.posterior_predictive[obs_id = obs_id_subset],
    observed_data=data.observed_data[obs_id = obs_id_subset],
)

pc = ArviZPythonPlots.arviz.plot_loo_interval(data_subset; backend="matplotlib")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "11_plot_loo_interval.png")) #hide
gcf()

# See [`plot_loo_interval`](@ref).
