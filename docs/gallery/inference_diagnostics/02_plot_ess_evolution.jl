# ---
# title: "ESS evolution"
# id: 02_plot_ess_evolution
# cover: assets/02_plot_ess_evolution.png
# description: "Faceted plot with ESS \"bulk\" and \"tail\" for each variable."
# ---
#
# # ESS evolution
#
# Faceted plot with ESS "bulk" and "tail" for each variable.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess_evolution(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "02_plot_ess_evolution.png")) #hide
gcf()

# See [`plot_ess_evolution`](@ref).
