# ---
# title: "Test statistics"
# id: 07_plot_ppc_tstat
# cover: assets/07_plot_ppc_tstat.png
# description: "T-statistic for the observed data and posterior predictive data."
# ---
#
# # Test statistics
#
# T-statistic for the observed data and posterior predictive data.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_ppc_tstat(data; t_stat="median")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "07_plot_ppc_tstat.png")) #hide
gcf()

# See [`plot_ppc_tstat`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks with summary statistics](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#using-summary-statistics).
