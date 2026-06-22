# ---
# title: "Rank plot"
# id: 00_plot_rank
# cover: assets/00_plot_rank.png
# description: "Faceted plot with fractional ranks for each variable."
# ---
#
# # Rank plot
#
# Faceted plot with fractional ranks for each variable.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_rank(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "00_plot_rank.png")) #hide
gcf()

# See [`plot_rank`](@ref).
