# ---
# title: "Plot prior and posterior"
# id: 06_plot_prior_posterior
# cover: assets/06_plot_prior_posterior.png
# description: "Plot prior and posterior marginal distributions."
# ---
#
# # Plot prior and posterior
#
# Plot prior and posterior marginal distributions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_prior_posterior(data; var_names="mu", kind="hist")
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "06_plot_prior_posterior.png")) #hide
gcf()

# See [`plot_prior_posterior`](@ref).
