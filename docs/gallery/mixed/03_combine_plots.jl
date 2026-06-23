# ---
# title: "Custom diagnostic plots combination"
# id: 03_combine_plots
# cover: assets/03_combine_plots.png
# description: "Arrange three diagnostic plots (ESS evolution plot, rank plot, and autocorrelation plot) in a custom column layout."
# ---
#
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
        (plot_ess_evolution, Dict()),
        (plot_rank, Dict()),
        (plot_autocorr, Dict()),
    ];
    var_names=["theta", "mu", "tau"],
    coords=Dict("school" => ["Hotchkiss", "St. Paul's"]),
)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "03_combine_plots.png")) #hide
gcf()

# See [`combine_plots`](@ref).
