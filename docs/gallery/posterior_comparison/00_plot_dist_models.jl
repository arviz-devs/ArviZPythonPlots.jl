# ---
# title: "Posterior KDEs for two models"
# id: 00_plot_dist_models
# cover: assets/00_plot_dist_models.png
# description: "Full marginal distribution comparison between different models."
# ---
#
# # Posterior KDEs for two models
#
# Full marginal distribution comparison between different models.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

c = load_example_data("centered_eight")
n = load_example_data("non_centered_eight")
pc = plot_dist(Dict("Centered" => c, "Non Centered" => n))
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "00_plot_dist_models.png")) #hide
gcf()

# See [`plot_dist`](@ref). Other examples comparing marginal distributions: see the "Posterior
# forest for two models" and "Ridge plot for multiple models" examples in this gallery section.
