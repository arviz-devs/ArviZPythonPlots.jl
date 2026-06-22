# ---
# title: "Linear model plot"
# id: 12_plot_lm
# cover: assets/12_plot_lm.png
# description: "Posterior predictive and mean plots for regression-like data. `plot_lm` visualizes credible intervals around predictions alongside observed data points."
# ---
#
# # Linear model plot
#
# Posterior predictive and mean plots for regression-like data. `plot_lm` visualizes credible
# intervals around predictions alongside observed data points.

using ArviZPythonPlots, InferenceObjects, DimensionalData, Random

use_style("arviz-variat")

rng = MersenneTwister(42)
x_data = randn(rng, 100)
y_data = 2 .+ x_data .* 0.5 .+ randn(rng, 100) .* 0.5
y_data_rep = 2 .+ reshape(x_data, 1, 1, :) .* 0.5 .+ randn(rng, 4, 200, 100) .* 0.5

obs_id = Dim{:obs_id}(0:99)
data = InferenceData(;
    posterior_predictive=Dataset((;
        y=DimArray(y_data_rep, (Dim{:chain}(0:3), Dim{:draw}(0:199), obs_id))
    )),
    observed_data=Dataset((; y=DimArray(y_data, (obs_id,)))),
    constant_data=Dataset((; x=DimArray(x_data, (obs_id,)))),
)

pc = plot_lm(data)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "12_plot_lm.png")) #hide
gcf()

# See [`plot_lm`](@ref).
