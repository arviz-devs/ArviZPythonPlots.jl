# # Parallel coordinates plot
#
# Plot parallel coordinates plot showing posterior points with divergences.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_parallel(
    data; var_names=["theta", "tau", "mu"], norm_method="rank", label_type="vert"
)
gcf()

# See [`plot_parallel`](@ref).
