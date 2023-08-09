using ArviZPythonPlots
using PythonCall
using Test

@testset "style" begin
    @testset "styles" begin
        @test styles() isa Vector{String}
        @test "arviz-darkgrid" ∈ styles()
        @test styles() ==
            map(Base.Fix1(pyconvert, String), ArviZPythonPlots.arviz.style.available)
    end

    @testset "use_style" begin
        use_style("arviz-darkgrid")
        use_style("default")
    end
end
