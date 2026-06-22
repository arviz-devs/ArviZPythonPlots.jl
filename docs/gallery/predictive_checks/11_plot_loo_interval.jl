# # Interval plot (LOO)
#
# Plot LOO posterior predictive point estimate and intervals at each observation.

using ArviZPythonPlots, ArviZExampleData, PythonCall

use_style("arviz-variat")

data = load_example_data("radon")
data_subset = Py(data).isel(; obs_id=pyrange(0, 50))
pc = ArviZPythonPlots.arviz.plot_loo_interval(data_subset; backend="matplotlib")
gcf()

# See [`plot_loo_interval`](@ref).
