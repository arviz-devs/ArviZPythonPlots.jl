# ---
# title: "Predictive model comparison"
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
gcf() #hide

# See [`plot_compare`](@ref).
