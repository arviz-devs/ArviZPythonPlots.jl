# ---
# title: "Interval plot"
# id: 08_plot_ppc_interval
# cover: assets/08_plot_ppc_interval.png
# description: "Plot posterior predictive point estimate and intervals at each observation."
# ---
#
# # Interval plot
#
# Plot posterior predictive point estimate and intervals at each observation.

using ArviZPythonPlots, ArviZExampleData, PythonCall

use_style("arviz-variat")

data = load_example_data("radon")
data_subset = Py(data).isel(; obs_id=pyrange(0, 50))
pc = ArviZPythonPlots.arviz.plot_ppc_interval(data_subset; backend="matplotlib")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "08_plot_ppc_interval.png")) #hide
gcf()

# See [`plot_ppc_interval`](@ref).
