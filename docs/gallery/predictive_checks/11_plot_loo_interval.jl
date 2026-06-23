# ---
# title: "Interval plot (LOO)"
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
    posterior=data.posterior,
    posterior_predictive=data.posterior_predictive[obs_id = obs_id_subset],
    log_likelihood=data.log_likelihood[obs_id = obs_id_subset],
    observed_data=data.observed_data[obs_id = obs_id_subset],
)

pc = plot_loo_interval(data_subset)
gcf()

# See [`plot_loo_interval`](@ref).
