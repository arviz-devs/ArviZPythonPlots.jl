# ---
# title: "PIT ECDF"
# id: 04_plot_ppc_pit
# cover: assets/04_plot_ppc_pit.png
# description: "Plot of the probability integral transform of the posterior predictive distribution with respect to the observed data."
# ---
#
# # PIT ECDF
#
# Plot of the probability integral transform of the posterior predictive distribution with
# respect to the observed data.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_ppc_pit(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "04_plot_ppc_pit.png")) #hide
gcf()

# See [`plot_ppc_pit`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks with PIT-ECDFs](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#pit-ecdfs).
