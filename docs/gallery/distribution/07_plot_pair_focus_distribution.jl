# ---
# title: "Scatterplot one variable against all others"
# id: 07_plot_pair_focus_distribution
# cover: assets/07_plot_pair_focus_distribution.png
# description: "Plot one variable against other variables in the dataset."
# ---
#
# # Scatterplot one variable against all others
#
# Plot one variable against other variables in the dataset.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_pair_focus(data, "mu"; var_names=["theta", "tau"])
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "07_plot_pair_focus_distribution.png")) #hide
gcf()

# See [`plot_pair_focus`](@ref).
