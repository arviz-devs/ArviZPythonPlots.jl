# ---
# title: "Sensitivity posterior quantities"
# id: 01_plot_psense_quantities
# cover: assets/01_plot_psense_quantities.png
# description: "The posterior quantities are computed by power-scaling the prior or likelihood and visualizing the resulting changes. Sensitivity can then be quantified by considering how much the perturbed quantities differ from the base quantities."
# ---
#
# # Sensitivity posterior quantities
#
# The posterior quantities are computed by power-scaling the prior or likelihood and
# visualizing the resulting changes. Sensitivity can then be quantified by considering how much
# the perturbed quantities differ from the base quantities.

using ArviZPythonPlots, ArviZExampleData, InferenceObjects

use_style("arviz-variat")

idata = load_example_data("rugby")
## the power-scaling sensitivity diagnostic needs every log_likelihood variable to share the
## sample dimensions, so drop the home_team/away_team string covariates that live there too
log_likelihood = Dataset((;
    home_points=idata.log_likelihood.home_points,
    away_points=idata.log_likelihood.away_points,
))
idata = merge(idata, InferenceData(; log_likelihood))

pc = plot_psense_quantities(
    idata; var_names=["sd_att", "sd_def"], quantities=["mean", "sd", "0.25", "0.75"]
)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "01_plot_psense_quantities.png")) #hide
gcf()

# See [`plot_psense_quantities`](@ref).
