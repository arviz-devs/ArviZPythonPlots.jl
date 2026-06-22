# ---
# title: "Rank and distribution plot"
# id: 00_plot_rank_dist
# cover: assets/00_plot_rank_dist.png
# description: "Two column layout with marginal distributions on the left and fractional ranks on the right."
# ---
#
# # Rank and distribution plot
#
# Two column layout with marginal distributions on the left and fractional ranks on the right.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("non_centered_eight")
pc = plot_rank_dist(data; var_names=["mu", "tau"])
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "00_plot_rank_dist.png")) #hide
gcf()

# See [`plot_rank_dist`](@ref).
