# ---
# title: "Pareto k parameter diagnostics"
# id: 01_plot_khat
# cover: assets/01_plot_khat.png
# description: "Default Pareto k diagnostic plot from PSIS-LOO-CV to assess importance sampling reliability."
# ---
#
# # Pareto k parameter diagnostics
#
# Default Pareto k diagnostic plot from PSIS-LOO-CV to assess importance sampling reliability.

using ArviZPythonPlots, ArviZExampleData, PosteriorStats

use_style("arviz-variat")

data = load_example_data("rugby")
elpd_data = loo(data; var_name=:home_points)
pc = plot_khat(elpd_data; threshold=0.7, visuals=Dict("hlines" => true, "bin_text" => true))
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "01_plot_khat.png")) #hide
gcf()

# See [`plot_khat`](@ref).
