# ---
# title: "Monte Carlo standard error"
# id: 05_plot_mcse
# cover: assets/05_plot_mcse.png
# description: "Faceted quantile MCSE plot."
# ---
#
# # Monte Carlo standard error
#
# Faceted quantile MCSE plot.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_mcse(data; extra_methods=true, var_names=["mu"])
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "05_plot_mcse.png")) #hide
gcf()

# See [`plot_mcse`](@ref).
