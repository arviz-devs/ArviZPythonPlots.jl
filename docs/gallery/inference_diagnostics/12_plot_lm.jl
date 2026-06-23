# ---
# title: "Linear model plot"
# description: "Posterior predictive and mean plots for regression-like data. `plot_lm` visualizes credible intervals around predictions alongside observed data points."
# ---
#
# # Linear model plot
#
# Posterior predictive and mean plots for regression-like data. `plot_lm` visualizes credible
# intervals around predictions alongside observed data points.

using ArviZPythonPlots, InferenceObjects, DimensionalData, Random

use_style("arviz-variat")

function generate_data(rng, x_data, sample_dims...)
    eps = similar(x_data, dims(x_data)..., sample_dims...)
    Random.randn!(rng, eps)
    y_data = @. 2 + (x_data + eps) / 2
    return y_data
end

rng = Xoshiro(42)
obs_dims = Dim{:obs_id}(1:100)
draw_dims = Dim{:draw}(1:200)
chain_dims = Dim{:chain}(1:4)

x_data = DimArray(randn(rng, length(obs_dims)), obs_dims)
y_data = generate_data(rng, x_data)
y_data_rep = generate_data(rng, x_data, draw_dims, chain_dims)

data = from_namedtuple(;
    posterior_predictive=(; y=y_data_rep),
    observed_data=(; y=y_data),
    constant_data=(; x=x_data),
)

pc = plot_lm(data)
gcf() #hide

# See [`plot_lm`](@ref).
