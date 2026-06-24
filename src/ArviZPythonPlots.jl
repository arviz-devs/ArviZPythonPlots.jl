module ArviZPythonPlots

using Base: @__doc__
using DimensionalData: DimensionalData, Dimensions
using InferenceObjects
using OrderedCollections: OrderedDict
using PosteriorStats
using PythonCall
using Reexport
using Tables

# Exports

@reexport using PythonPlot

## Plots
const _PLOT_FUNCTIONS = (
    :combine_plots,
    :plot_autocorr,
    :plot_bf,
    :plot_compare,
    :plot_convergence_dist,
    :plot_dgof,
    :plot_dgof_dist,
    :plot_dist,
    :plot_ecdf_pit,
    :plot_energy,
    :plot_ess,
    :plot_ess_evolution,
    :plot_forest,
    :plot_khat,
    :plot_lm,
    :plot_loo_interval,
    :plot_loo_pit,
    :plot_mcse,
    :plot_pair,
    :plot_pair_focus,
    :plot_parallel,
    :plot_ppc_censored,
    :plot_ppc_dist,
    :plot_ppc_dist_pit,
    :plot_ppc_interval,
    :plot_ppc_pava,
    :plot_ppc_pava_residuals,
    :plot_ppc_pit,
    :plot_ppc_rootogram,
    :plot_ppc_tstat,
    :plot_prior_posterior,
    :plot_psense_dist,
    :plot_psense_quantities,
    :plot_rank,
    :plot_rank_dist,
    :plot_ridge,
    :plot_trace,
    :plot_trace_dist,
)
for f in _PLOT_FUNCTIONS
    @eval export $f
end

## rcParams
export rcParams, rc_context

## styles
export styles, use_style

const arviz = PythonCall.pynew()
const xarray = PythonCall.pynew()
const pandas = PythonCall.pynew()

function __init__()
    PythonCall.pycopy!(arviz, pyimport("arviz"))
    PythonCall.pycopy!(xarray, pyimport("xarray"))
    PythonCall.pycopy!(pandas, pyimport("pandas"))
    PythonCall.pycopy!(rcParams, arviz.rcParams)
    # use 1-based indexing in plots
    rcParams["data.index_origin"] = 1
    return nothing
end

include("lazyhelp.jl")
include("utils.jl")
include("rcparams.jl")
include("style.jl")
include("xarray.jl")
include("conversions.jl")
include("plots.jl")

end # module
