# # Coverage ECDF
#
# Proportion of true values that fall within a given prediction interval.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_ppc_pit(data; coverage=true)
gcf()

# See [`plot_ppc_pit`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks and coverage](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#coverage).
