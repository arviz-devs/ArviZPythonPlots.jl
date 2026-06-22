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
gcf()

# See [`plot_ppc_rootogram`](@ref).
#
# See also the EABM chapter on [Posterior predictive checks for count data](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#posterior-predictive-checks-for-count-data).
