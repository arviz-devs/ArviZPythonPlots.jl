# ---
# title: "ESS quantile"
# id: 04_plot_ess_quantile
# cover: assets/04_plot_ess_quantile.png
# description: "Faceted quantile ESS plot."
# ---
#
# # ESS quantile
#
# Faceted quantile ESS plot.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess(data; kind="quantile")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "04_plot_ess_quantile.png")) #hide
gcf()

# See [`plot_ess`](@ref).
