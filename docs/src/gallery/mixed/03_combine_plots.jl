# # Custom diagnostic plots combination
#
# Arrange three diagnostic plots (ESS evolution plot, rank plot, and autocorrelation plot) in a
# custom column layout.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("non_centered_eight")
pc = combine_plots(
    data,
    [
        (ArviZPythonPlots.arviz.plot_ess_evolution, Dict()),
        (ArviZPythonPlots.arviz.plot_rank, Dict()),
        (ArviZPythonPlots.arviz.plot_autocorr, Dict()),
    ];
    var_names=["theta", "mu", "tau"],
    coords=Dict("school" => ["Hotchkiss", "St. Paul's"]),
)
gcf()

# See [`combine_plots`](@ref).
