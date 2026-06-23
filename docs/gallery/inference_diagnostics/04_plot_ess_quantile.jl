# ---
# title: "ESS quantile"
# description: "Faceted quantile ESS plot."
# ---
#
# # ESS quantile
#
# Faceted quantile ESS plot.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess(data; kind="quantile")
gcf() #hide

# See [`plot_ess`](@ref).
