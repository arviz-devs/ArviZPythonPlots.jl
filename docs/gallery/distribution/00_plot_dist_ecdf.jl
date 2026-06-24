# # Posterior ECDFs
#
# Faceted ECDF plots for 1D marginals of the distribution.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_dist(data; kind="ecdf", col_wrap=4)
gcf() #hide

# See [`plot_dist`](@ref).
#
# See also the EABM chapter on [Visualization of Random Variables with ArviZ](https://arviz-devs.github.io/EABM/Chapters/Distributions.html#distributions-in-arviz).
