using ArviZPythonPlots
using DataFrames: DataFrames
using PythonCall
using Test

pandas = ArviZPythonPlots.pandas

@testset "utils" begin
    @testset "topandas" begin
        @testset "Table -> pandas.DataFrame" begin
            columns = [:a, :b, :c]
            index = ["d", "e"]
            rowvals = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]
            table = (i=["d", "e"], a=[1.0, 4.0], b=[2.0, 5.0], c=[3.0, 6.0])
            pdf = ArviZPythonPlots.topandas(Val(:DataFrame), table; index_name=:i)
            @test pyisinstance(pdf, pandas.DataFrame)
            pdf_exp = pandas.DataFrame(
                Py(rowvals);
                columns=pylist(map(pystr, columns)),
                index=pylist(map(pystr, index)),
            )
            @test pyconvert(Bool, pyall(pyeq(pdf, pdf_exp)))
        end
    end
end
