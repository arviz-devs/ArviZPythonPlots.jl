# ---
# title: "Forest plot with shading"
# id: 05_plot_forest_shade
# cover: assets/05_plot_forest_shade.png
# description: "Forest plot marginal summaries with row shading to enhance reading."
# ---
#
# # Forest plot with shading
#
# Forest plot marginal summaries with row shading to enhance reading.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_forest(data; var_names=["home", "atts", "defs"], shade_label="team")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "05_plot_forest_shade.png")) #hide
gcf()

# See [`plot_forest`](@ref).
