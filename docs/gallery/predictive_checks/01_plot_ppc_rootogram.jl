# ---
# title: "Rootogram"
# id: 01_plot_ppc_rootogram
# cover: assets/01_plot_ppc_rootogram.png
# description: "Rootogram for the posterior predictive and observed data."
# ---
#
# # Rootogram
#
# Rootogram for the posterior predictive and observed data.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_ppc_rootogram(
    data;
    var_names=["home_points", "away_points"],
    aes=Dict("color" => ["__variable__"]),
    aes_by_visuals=Dict("title" => ["color"]),
)
pc.add_title("Posterior Predictive Rootogram for Rugby Model")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "01_plot_ppc_rootogram.png")) #hide
gcf()

# See [`plot_ppc_rootogram`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks for count data](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#posterior-predictive-checks-for-count-data).
