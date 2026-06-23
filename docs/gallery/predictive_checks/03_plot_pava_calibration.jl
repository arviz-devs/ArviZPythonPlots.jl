# # PAV-adjusted calibration
#
# PAV-adjusted calibration plot for binary predictions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("anes")
pc = plot_ppc_pava(data)
gcf() #hide

# See [`plot_ppc_pava`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks for binary data](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#posterior-predictive-checks-for-binary-data).
