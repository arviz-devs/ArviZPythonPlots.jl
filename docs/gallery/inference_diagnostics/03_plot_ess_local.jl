# ---
# title: "ESS local"
# description: "Faceted local ESS plot."
# ---
#
# # ESS local
#
# Faceted local ESS plot.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess(data; kind="local", rug=true)
gcf() #hide

# See [`plot_ess`](@ref).
