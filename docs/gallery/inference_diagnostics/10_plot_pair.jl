# ---
# title: "Scatter plot of all variables against each other with divergences"
# id: 10_plot_pair
# cover: assets/10_plot_pair.png
# description: "Plot all variables against each other in the dataset."
# ---
#
# # Scatter plot of all variables against each other with divergences
#
# Plot all variables against each other in the dataset.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_pair(
    data;
    var_names=["theta", "tau"],
    coords=Dict("school" => ["Lawrenceville", "Mt. Hermon"]),
    visuals=Dict("divergence" => true),
    marginal=false,
)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "10_plot_pair.png")) #hide
gcf()

# See [`plot_pair`](@ref).
