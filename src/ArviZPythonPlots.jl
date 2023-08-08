module ArviZPythonPlots

using Base: @__doc__
using DataFrames
using OrderedCollections: OrderedDict

using Reexport
@reexport using ArviZ
@reexport using PyPlot
using PyCall
using Conda
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

const _min_arviz_version = v"0.13.0"
const arviz = PyNULL()
const xarray = PyNULL()
const pandas = PyNULL()
const _rcParams = PyNULL()

include("setup.jl")

# Load ArviZ once at precompilation time for docstringS
copy!(arviz, import_arviz())
check_needs_update(; update=false)
const _precompile_arviz_version = arviz_version()

function __init__()
    return initialize_arviz()
end

include("lazyhelp.jl")
include("utils.jl")
include("rcparams.jl")
include("style.jl")
include("xarray.jl")
include("conversions.jl")
include("plots.jl")

end # module
