using ArviZPyPlot
using DataFrames: DataFrames
using PyCall
using Test

pandas = ArviZPyPlot.pandas

@testset "utils" begin
    @testset "frompytype" begin
        x = 1.0
        @test ArviZPyPlot.frompytype(x) === x
        x2 = PyObject(x)
        @test ArviZPyPlot.frompytype(x2) == x
        @test ArviZPyPlot.frompytype([x2]) == [x]
        @test ArviZPyPlot.frompytype(Any[x2]) == [x]
        @test eltype(ArviZPyPlot.frompytype(Any[x2])) <: Real
        @test ArviZPyPlot.frompytype([[x2]]) == [[x]]
    end

    @testset "topandas" begin
        @testset "DataFrames.DataFrame -> pandas.DataFrame" begin
            columns = [:a, :b, :c]
            index = ["d", "e"]
            rowvals = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]
            df = DataFrames.DataFrame([
                :i => ["d", "e"], :a => [1.0, 4.0], :b => [2.0, 5.0], :c => [3.0, 6.0]
            ])
            pdf = ArviZPyPlot.topandas(Val(:DataFrame), df; index_name=:i)
            @test pyisinstance(pdf, pandas.DataFrame)
            pdf_exp = pandas.DataFrame(rowvals; columns, index)
            @test py"($(pdf) == $(pdf_exp)).all().all()"
        end

        @testset "DataFrames.DataFrame -> pandas.Series" begin
            df2 = DataFrames.DataFrame([:a => [1.0], :b => [2.0], :c => [3.0]])
            ps = ArviZPyPlot.topandas(Val(:Series), df2)
            @test pyisinstance(ps, pandas.Series)
            ps_exp = pandas.Series([1.0, 2.0, 3.0], [:a, :b, :c])
            @test py"($(ps) == $(ps_exp)).all()"
        end
    end

    @testset "todataframes" begin
        @testset "pandas.DataFrame -> DataFrames.DataFrame" begin
            columns = [:a, :b, :c]
            index = ["d", "e"]
            rowvals = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]
            pdf = pandas.DataFrame(rowvals; columns, index)
            df = ArviZPyPlot.todataframes(pdf; index_name=:i)
            @test df isa DataFrames.DataFrame
            @test df == DataFrames.DataFrame([
                :i => ["d", "e"], :a => [1.0, 4.0], :b => [2.0, 5.0], :c => [3.0, 6.0]
            ])
            @test df == ArviZPyPlot.todataframes(pdf; index_name=:i)
        end

        @testset "pandas.Series -> DataFrames.DataFrame" begin
            ps = pandas.Series([1.0, 2.0, 3.0], [:a, :b, :c])
            df2 = ArviZPyPlot.todataframes(ps)
            @test df2 isa DataFrames.DataFrame
            @test df2 == DataFrames.DataFrame([:a => [1.0], :b => [2.0], :c => [3.0]])
            @test df2 == ArviZPyPlot.todataframes(ps)
        end
    end

    @testset "styles" begin
        @test ArviZPyPlot.styles() isa AbstractArray{String}
        @test "arviz-darkgrid" ∈ ArviZPyPlot.styles()
        @test ArviZPyPlot.styles() == ArviZPyPlot.arviz.style.available
    end

    @testset "use_style" begin
        ArviZPyPlot.use_style("arviz-darkgrid")
        ArviZPyPlot.use_style("default")
    end
end
