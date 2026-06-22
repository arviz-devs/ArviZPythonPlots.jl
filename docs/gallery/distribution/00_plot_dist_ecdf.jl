# ---
# title: "Posterior ECDFs"
# id: 00_plot_dist_ecdf
# cover: assets/00_plot_dist_ecdf.png
# description: "Faceted ECDF plots for 1D marginals of the distribution."
# ---
#
# # Posterior ECDFs
#
# Faceted ECDF plots for 1D marginals of the distribution.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_dist(data; kind="ecdf", col_wrap=4)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "00_plot_dist_ecdf.png")) #hide
gcf()

# See [`plot_dist`](@ref).
#
# See also the EABM chapter on [Visualization of Random Variables with ArviZ](https://arviz-devs.github.io/EABM/Chapters/Distributions.html#distributions-in-arviz).
