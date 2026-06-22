# ---
# title: "PAV-adjusted calibration"
# id: 03_plot_pava_calibration
# cover: assets/03_plot_pava_calibration.png
# description: "PAV-adjusted calibration plot for binary predictions."
# ---
#
# # PAV-adjusted calibration
#
# PAV-adjusted calibration plot for binary predictions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("anes")
pc = plot_ppc_pava(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "03_plot_pava_calibration.png")) #hide
gcf()

# See [`plot_ppc_pava`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks for binary data](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#posterior-predictive-checks-for-binary-data).
