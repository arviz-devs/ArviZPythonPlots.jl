# ---
# title: "Energy"
# id: 08_plot_energy
# cover: assets/08_plot_energy.png
# description: "Plot transition and marginal energy distributions."
# ---
#
# # Energy
#
# Plot transition and marginal energy distributions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_energy(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "08_plot_energy.png")) #hide
gcf()

# See [`plot_energy`](@ref).
