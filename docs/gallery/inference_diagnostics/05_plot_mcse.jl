# ---
# title: "Monte Carlo standard error"
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
gcf()

# See [`plot_mcse`](@ref).
