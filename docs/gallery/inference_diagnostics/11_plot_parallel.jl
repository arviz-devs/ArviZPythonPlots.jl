# ---
# title: "Parallel coordinates plot"
# id: 11_plot_parallel
# cover: assets/11_plot_parallel.png
# description: "Plot parallel coordinates plot showing posterior points with divergences."
# ---
#
# # Parallel coordinates plot
#
# Plot parallel coordinates plot showing posterior points with divergences.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_parallel(
    data; var_names=["theta", "tau", "mu"], norm_method="rank", label_type="vert"
)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "11_plot_parallel.png")) #hide
gcf()

# See [`plot_parallel`](@ref).
