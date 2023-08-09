using ArviZPythonPlots
using DataFrames: DataFrames
using PythonCall
using Test

pandas = ArviZPythonPlots.pandas

@testset "utils" begin
    @testset "frompytype" begin
        x = 1.0
        @test ArviZPythonPlots.frompytype(x) === x
        x2 = Py(x)
        @test ArviZPythonPlots.frompytype(x2) == x
        @test ArviZPythonPlots.frompytype(pylist([x2])) == [x]
        @test ArviZPythonPlots.frompytype(Py([x 2x]).to_numpy()) == [x 2x]
        @test eltype(ArviZPythonPlots.frompytype(Any[x2])) <: Real
        @test ArviZPythonPlots.frompytype([[x2]]) == [[x]]
    end

    @testset "topandas" begin
        @testset "DataFrames.DataFrame -> pandas.DataFrame" begin
            columns = [:a, :b, :c]
            index = ["d", "e"]
            rowvals = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]
            df = DataFrames.DataFrame([
                :i => ["d", "e"], :a => [1.0, 4.0], :b => [2.0, 5.0], :c => [3.0, 6.0]
            ])
            pdf = ArviZPythonPlots.topandas(Val(:DataFrame), df; index_name=:i)
            @test pyisinstance(pdf, pandas.DataFrame)
            pdf_exp = pandas.DataFrame(rowvals; columns, index)
            @test pyconvert(Bool, pyall(pyeq(pdf, pdf_exp)))
        end

        @testset "DataFrames.DataFrame -> pandas.Series" begin
            df2 = DataFrames.DataFrame([:a => [1.0], :b => [2.0], :c => [3.0]])
            ps = ArviZPythonPlots.topandas(Val(:Series), df2)
            @test pyisinstance(ps, pandas.Series)
            ps_exp = pandas.Series([1.0, 2.0, 3.0], [:a, :b, :c])
            @test pyconvert(Bool, pyall(pyeq(ps, ps_exp)))
        end
    end

    @testset "todataframes" begin
        @testset "pandas.DataFrame -> DataFrames.DataFrame" begin
            columns = [:a, :b, :c]
            index = ["d", "e"]
            rowvals = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]
            pdf = pandas.DataFrame(rowvals; columns, index)
            df = ArviZPythonPlots.todataframes(pdf; index_name=:i)
            @test df isa DataFrames.DataFrame
            @test df == DataFrames.DataFrame([
                :i => ["d", "e"], :a => [1.0, 4.0], :b => [2.0, 5.0], :c => [3.0, 6.0]
            ])
            @test df == ArviZPythonPlots.todataframes(pdf; index_name=:i)
        end

        @testset "pandas.Series -> DataFrames.DataFrame" begin
            ps = pandas.Series([1.0, 2.0, 3.0], [:a, :b, :c])
            df2 = ArviZPythonPlots.todataframes(ps)
            @test df2 isa DataFrames.DataFrame
            @test df2 == DataFrames.DataFrame([:a => [1.0], :b => [2.0], :c => [3.0]])
            @test df2 == ArviZPythonPlots.todataframes(ps)
        end
    end

    @testset "styles" begin
        @test styles() isa AbstractArray{String}
        @test "arviz-darkgrid" ∈ styles()
        @test styles() ==
            map(Base.Fix1(pyconvert, String), ArviZPythonPlots.arviz.style.available)
    end

    @testset "use_style" begin
        use_style("arviz-darkgrid")
        use_style("default")
    end
end
