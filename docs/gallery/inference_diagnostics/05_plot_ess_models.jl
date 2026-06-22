# ---
# title: "ESS comparison"
# id: 05_plot_ess_models
# cover: assets/05_plot_ess_models.png
# description: "Full ESS (either local or quantile) comparison between different models."
# ---
#
# # ESS comparison
#
# Full ESS (either local or quantile) comparison between different models.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

c = load_example_data("centered_eight")
n = load_example_data("non_centered_eight")
pc = plot_ess(Dict("Centered" => c, "Non Centered" => n))
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "05_plot_ess_models.png")) #hide
gcf()

# See [`plot_ess`](@ref).
