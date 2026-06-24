# # Scatterplot one variable against all others
#
# Plot one variable against other variables in the dataset.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_pair_focus(data, "mu"; var_names=["theta", "tau"])
gcf() #hide

# See [`plot_pair_focus`](@ref).
