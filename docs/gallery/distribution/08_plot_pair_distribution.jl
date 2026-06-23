# ---
# title: "Scatterplot all variables against each other"
# description: "Plot all variables against each other in the dataset."
# ---
#
# # Scatterplot all variables against each other
#
# Plot all variables against each other in the dataset.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_pair(
    data; var_names=["mu", "theta", "tau"], coords=Dict("school" => ["Choate", "Deerfield"])
)
gcf() #hide

# See [`plot_pair`](@ref).
