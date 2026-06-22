# ---
# title: "Predictive check with ECDF and PIT Δ-ECDFs"
# id: 12_plot_ppc_dist_pit
# cover: assets/12_plot_ppc_dist_pit.png
# description: "Plot of the ECDF (right) of the PIT values (left) for samples from the posterior predictive and observed data."
# ---
#
# # Predictive check with ECDF and PIT Δ-ECDFs
#
# Plot of the ECDF (right) of the PIT values (left) for samples from the posterior predictive
# and observed data.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_ppc_dist_pit(data; kind="ecdf", var_names=["home_points", "away_points"])
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "12_plot_ppc_dist_pit.png")) #hide
gcf()

# See [`plot_ppc_dist_pit`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks with PIT-ECDFs](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#pit-ecdfs).
