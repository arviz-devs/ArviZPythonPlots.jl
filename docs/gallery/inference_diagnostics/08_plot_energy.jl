# # Energy
#
# Plot transition and marginal energy distributions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_energy(data)
gcf() #hide

# See [`plot_energy`](@ref).
