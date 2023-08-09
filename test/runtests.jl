using ArviZPythonPlots
using Test

@testset "ArviZPythonPlots" begin
    include("helpers.jl")
    include("test_rcparams.jl")
    include("test_style.jl")
    include("test_utils.jl")
    include("test_conversions.jl")
    include("test_xarray.jl")
    include("test_plots.jl")
end
