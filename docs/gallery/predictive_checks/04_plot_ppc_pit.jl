# # PIT ECDF
#
# Plot of the probability integral transform of the posterior predictive distribution with
# respect to the observed data.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_ppc_pit(data)
gcf() #hide

# See [`plot_ppc_pit`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks with PIT-ECDFs](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#pit-ecdfs).
