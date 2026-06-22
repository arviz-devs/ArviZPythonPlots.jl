# # Scatter plot of all variables against each other with divergences
#
# Plot all variables against each other in the dataset.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_pair(
    data;
    var_names=["theta", "tau"],
    coords=Dict("school" => ["Lawrenceville", "Mt. Hermon"]),
    visuals=Dict("divergence" => true),
    marginal=false,
)
gcf()

# See [`plot_pair`](@ref).
