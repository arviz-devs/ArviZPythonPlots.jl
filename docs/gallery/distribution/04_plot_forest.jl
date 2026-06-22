# ---
# title: "Forest plot"
# id: 04_plot_forest
# cover: assets/04_plot_forest.png
# description: "Default forest plot with marginal distribution summaries."
# ---
#
# # Forest plot
#
# Default forest plot with marginal distribution summaries.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_forest(data; var_names=["home", "atts", "defs"])
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "04_plot_forest.png")) #hide
gcf()

# See [`plot_forest`](@ref).
