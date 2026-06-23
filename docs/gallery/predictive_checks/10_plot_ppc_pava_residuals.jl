# ---
# title: "PAV-adjusted residual plot"
# description: "Residual plot using PAV-adjusted calibration for binary predictions."
# ---
#
# # PAV-adjusted residual plot
#
# Residual plot using PAV-adjusted calibration for binary predictions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("roaches_zinb")
pc = plot_ppc_pava_residuals(data, "roach count"; var_names="y_pos")
gcf()

# See [`plot_ppc_pava_residuals`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks for binary data](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#posterior-predictive-checks-for-binary-data).
