# ---
# title: "Diagnostics for density estimation"
# id: 09_plot_dgof
# cover: assets/09_plot_dgof.png
# description: "Diagnostics for assessing the goodness-of-fit of estimated distributions to the underlying data using the Probability Integral Transform (PIT) and the Δ-ECDF-PIT plots."
# ---
#
# # Diagnostics for density estimation
#
# Diagnostics for assessing the goodness-of-fit of estimated distributions to the underlying
# data using the Probability Integral Transform (PIT) and the Δ-ECDF-PIT plots.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_dgof(data; var_names="g", kind="hist", stats=Dict("dist" => Dict("bins" => 30)))
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "09_plot_dgof.png")) #hide
gcf()

# See [`plot_dgof`](@ref).
#
# See also the EABM chapter on [Visualization of Random Variables with ArviZ](https://arviz-devs.github.io/EABM/Chapters/Distributions.html).
