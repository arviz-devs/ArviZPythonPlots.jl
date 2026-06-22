# ---
# title: "ESS local"
# id: 03_plot_ess_local
# cover: assets/03_plot_ess_local.png
# description: "Faceted local ESS plot."
# ---
#
# # ESS local
#
# Faceted local ESS plot.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess(data; kind="local", rug=true)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "03_plot_ess_local.png")) #hide
gcf()

# See [`plot_ess`](@ref).
