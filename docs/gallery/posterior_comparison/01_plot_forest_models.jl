# ---
# title: "Posterior forest for two models"
# id: 01_plot_forest_models
# cover: assets/01_plot_forest_models.png
# description: "Forest plot summaries for 1D marginal distributions."
# ---
#
# # Posterior forest for two models
#
# Forest plot summaries for 1D marginal distributions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

c = load_example_data("centered_eight")
n = load_example_data("non_centered_eight")
pc = plot_forest(Dict("Centered" => c, "Non Centered" => n))
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "01_plot_forest_models.png")) #hide
gcf()

# See [`plot_forest`](@ref). Other examples comparing marginal distributions: see the "Posterior
# KDEs for two models" example in this gallery section.
