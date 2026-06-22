# ---
# title: "Convergence diagnostics distribution"
# id: 06_plot_convergence_dist
# cover: assets/06_plot_convergence_dist.png
# description: "Plot the distribution of ESS and R-hat."
# ---
#
# # Convergence diagnostics distribution
#
# Plot the distribution of ESS and R-hat.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_convergence_dist(data; var_names=["za_county"])
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "06_plot_convergence_dist.png")) #hide
gcf()

# See [`plot_convergence_dist`](@ref).
