# ---
# title: "LOO-PIT ECDF"
# description: "Plot of the probability integral transform of the posterior predictive distribution with respect to the observed data using the leave-one-out (LOO) method."
# ---
#
# # LOO-PIT ECDF
#
# Plot of the probability integral transform of the posterior predictive distribution with
# respect to the observed data using the leave-one-out (LOO) method.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_loo_pit(data)
gcf() #hide

# See [`plot_loo_pit`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks with LOO-PIT ECDFs](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#sec-avoid-double-dipping).
