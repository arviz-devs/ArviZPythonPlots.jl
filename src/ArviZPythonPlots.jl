module ArviZPythonPlots

using Base: @__doc__
using DataFrames
using OrderedCollections: OrderedDict

using Reexport
@reexport using ArviZ
using PythonCall
@reexport using PythonPlot
using DimensionalData: DimensionalData, Dimensions

import Base.Docs: getdoc
import Markdown: @doc_str

# Exports

## Plots
export plot_autocorr,
    plot_bpv,
    plot_compare,
    plot_density,
    plot_dist,
    plot_dist_comparison,
    plot_elpd,
    plot_energy,
    plot_ess,
    plot_forest,
    plot_hdi,
    plot_kde,
    plot_khat,
    plot_loo_pit,
    plot_mcse,
    plot_pair,
    plot_parallel,
    plot_posterior,
    plot_ppc,
    plot_rank,
    plot_separation,
    plot_trace,
    plot_violin

## rcParams
export rcParams, with_rc_context

## styles
export styles, use_style

const arviz = PythonCall.pynew()
const xarray = PythonCall.pynew()
const pandas = PythonCall.pynew()
const pyplot = PythonCall.pynew()
# const _rcParams = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(arviz, pyimport("arviz"))
    PythonCall.pycopy!(xarray, pyimport("xarray"))
    PythonCall.pycopy!(pandas, pyimport("pandas"))
    PythonCall.pycopy!(pyplot, pyimport("matplotlib" => "pyplot"))
    # PythonCall.pycopy!(_rcParams, arviz.rcParams)
end

include("lazyhelp.jl")
include("utils.jl")
# include("rcparams.jl")
include("style.jl")
include("xarray.jl")
include("conversions.jl")
include("plots.jl")

end # module
