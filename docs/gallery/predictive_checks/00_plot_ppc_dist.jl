# ---
# title: "Predictive check with KDEs"
# description: "Plot of samples from the posterior predictive and observed data."
# ---
#
# # Predictive check with KDEs
#
# Plot of samples from the posterior predictive and observed data.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_ppc_dist(data)
gcf()

# See [`plot_ppc_dist`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#posterior-predictive-checks).
