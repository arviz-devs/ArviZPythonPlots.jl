# ---
# title: "Survival analysis (censored data)"
# id: 09_plot_ppc_censored
# cover: assets/09_plot_ppc_censored.png
# description: "Plot Kaplan-Meier survival curve vs posterior predictive draws."
# ---
#
# # Survival analysis (censored data)
#
# Plot Kaplan-Meier survival curve vs posterior predictive draws.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("censored_cats")
pc = plot_ppc_censored(data; extrapolation_factor=nothing)
pc.facet_map("set_xscale"; scale="sqrt")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "09_plot_ppc_censored.png")) #hide
gcf()

# See [`plot_ppc_censored`](@ref).
