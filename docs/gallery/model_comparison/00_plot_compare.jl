# ---
# title: "Predictive model comparison"
# id: 00_plot_compare
# cover: assets/00_plot_compare.png
# description: "Compare multiple models using predictive accuracy estimated using PSIS-LOO-CV."
# ---
#
# # Predictive model comparison
#
# Compare multiple models using predictive accuracy estimated using PSIS-LOO-CV. The `mc`
# argument is generated using [`PosteriorStats.compare`](@extref).

using ArviZPythonPlots, ArviZExampleData, PosteriorStats

use_style("arviz-variat")

models = (
    centered=load_example_data("centered_eight"),
    non_centered=load_example_data("non_centered_eight"),
)
mc = compare(models)
pc = plot_compare(mc)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "00_plot_compare.png")) #hide
gcf()

# See [`plot_compare`](@ref).
