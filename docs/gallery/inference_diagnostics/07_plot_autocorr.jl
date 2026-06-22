# ---
# title: "Autocorrelation Plot"
# id: 07_plot_autocorr
# cover: assets/07_plot_autocorr.png
# description: "Faceted plot with autocorrelation for each variable."
# ---
#
# # Autocorrelation Plot
#
# Faceted plot with autocorrelation for each variable.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_autocorr(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "07_plot_autocorr.png")) #hide
gcf()

# See [`plot_autocorr`](@ref).
