# ---
# title: "Trace and distribution plot"
# id: 01_plot_trace_dist
# cover: assets/01_plot_trace_dist.png
# description: "Two column layout with marginal distributions on the left and MCMC traces on the right."
# ---
#
# # Trace and distribution plot
#
# Two column layout with marginal distributions on the left and MCMC traces on the right.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("non_centered_eight")
pc = plot_trace_dist(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "01_plot_trace_dist.png")) #hide
gcf()

# See [`plot_trace_dist`](@ref).
