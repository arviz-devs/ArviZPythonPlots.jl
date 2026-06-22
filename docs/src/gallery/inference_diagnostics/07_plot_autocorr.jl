# # Autocorrelation Plot
#
# Faceted plot with autocorrelation for each variable.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_autocorr(data)
gcf()

# See [`plot_autocorr`](@ref).
