# ---
# title: "Trace plot"
# id: 01_plot_trace
# cover: assets/01_plot_trace.png
# description: "Faceted plot with MCMC traces for each variable."
# ---
#
# # Trace plot
#
# Faceted plot with MCMC traces for each variable.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_trace(data)
pc.add_title("MCMC Sampling Traces: Centered Eight Model")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "01_plot_trace.png")) #hide
gcf()

# See [`plot_trace`](@ref).
