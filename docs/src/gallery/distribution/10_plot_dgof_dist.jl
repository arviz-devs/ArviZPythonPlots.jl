# # Density and diagnostics for density estimation
#
# Diagnostics for assessing the goodness-of-fit of estimated distributions to the underlying
# data using the Probability Integral Transform (PIT) and the Δ-ECDF-PIT plots.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_dgof_dist(data; var_names="g", kind="kde")
gcf()

# See [`plot_dgof_dist`](@ref).
#
# See also the EABM chapter on [Visualization of Random Variables with ArviZ](https://arviz-devs.github.io/EABM/Chapters/Distributions.html).
