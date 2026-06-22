# ---
# title: "Ridge plot"
# id: 08_plot_ridge
# cover: assets/08_plot_ridge.png
# description: "Visual representation of marginal distributions over the y axis for a single model."
# ---
#
# # Ridge plot
#
# Visual representation of marginal distributions over the y axis for a single model.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ridge(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "08_plot_ridge.png")) #hide
gcf()

# See [`plot_ridge`](@ref).
