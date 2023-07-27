using ArviZPyPlot
using Test

@testset "ArviZPyPlot" begin
    include("helpers.jl")
    include("test_rcparams.jl")
    include("test_utils.jl")
    include("test_conversions.jl")
    include("test_plots.jl")
end
