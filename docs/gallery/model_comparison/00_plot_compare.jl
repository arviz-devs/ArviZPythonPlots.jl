# ---
# title: "Predictive model comparison"
# id: 00_plot_compare
# cover: assets/00_plot_compare.png
# description: "Compare multiple models using predictive accuracy estimated using PSIS-LOO-CV."
# ---
#
# # Predictive model comparison
#
# Compare multiple models using predictive accuracy estimated using PSIS-LOO-CV. Usually the
# `cmp_df` is generated using [`compare`](https://julia.arviz.org/ArviZ/stable/api/stats/#ArviZ.compare).

using ArviZPythonPlots, PythonCall

use_style("arviz-variat")

cmp_df = ArviZPythonPlots.pandas.DataFrame(
    pydict(
        "elpd" => pylist([-4.5, -14.3, -16.2]),
        "p" => pylist([2.6, 2.3, 2.1]),
        "elpd_diff" => pylist([0, -9.7, -11.3]),
        "weight" => pylist([0.9, 0.1, 0]),
        "se" => pylist([2.3, 2.7, 2.3]),
        "dse" => pylist([0, 2.7, 2.3]),
        "warning" => pylist([false, false, false]),
    );
    index=pylist(["Model B", "Model A", "Model C"]),
)
pc = plot_compare(cmp_df)
mkpath(joinpath(@__DIR__, "assets")) #hide
savefig(joinpath(@__DIR__, "assets", "00_plot_compare.png")) #hide
gcf()

# See [`plot_compare`](@ref).
