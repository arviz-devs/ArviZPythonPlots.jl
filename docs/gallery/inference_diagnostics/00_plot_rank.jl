# ---
# title: "Rank plot"
# description: "Faceted plot with fractional ranks for each variable."
# ---
#
# # Rank plot
#
# Faceted plot with fractional ranks for each variable.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_rank(data)
gcf()

# See [`plot_rank`](@ref).
