# ---
# title: "Ridge plot"
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
gcf() #hide

# See [`plot_ridge`](@ref).
