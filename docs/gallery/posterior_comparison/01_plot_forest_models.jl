# ---
# title: "Posterior forest for two models"
# description: "Forest plot summaries for 1D marginal distributions."
# ---
#
# # Posterior forest for two models
#
# Forest plot summaries for 1D marginal distributions.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

c = load_example_data("centered_eight")
n = load_example_data("non_centered_eight")
pc = plot_forest(Dict("Centered" => c, "Non Centered" => n))
gcf()

# See [`plot_forest`](@ref). Other examples comparing marginal distributions: see the "Posterior
# KDEs for two models" example in this gallery section.
