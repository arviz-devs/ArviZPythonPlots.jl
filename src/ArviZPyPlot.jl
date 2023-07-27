__precompile__()
module ArviZPyPlot

using Base: @__doc__
using Requires
using REPL
using DataFrames
using JSON3: JSON3, StructTypes
using OrderedCollections: OrderedDict

using Reexport
@reexport using ArviZ
@reexport using PyPlot
using PyCall
using Conda
using DataDeps: DataDeps
using DimensionalData: DimensionalData, Dimensions
using LogExpFunctions: logsumexp

import Base:
    convert,
    get,
    getindex,
    getproperty,
    hash,
    haskey,
    iterate,
    length,
    propertynames,
    setindex,
    show,
    write,
    +
import Base.Docs: getdoc
using StatsBase: StatsBase
import StatsBase: summarystats
import Markdown: @doc_str
import PyCall: PyObject

using InferenceObjects
import InferenceObjects: convert_to_inference_data, namedtuple_of_arrays
# internal functions temporarily used/extended here
using InferenceObjects:
    attributes, recursive_stack, groupnames, groups, hasgroup, rekey, setattribute!
import InferenceObjects: namedtuple_of_arrays
using InferenceObjects: from_netcdf, to_netcdf

using MCMCDiagnosticTools:
    MCMCDiagnosticTools,
    AutocovMethod,
    FFTAutocovMethod,
    BDAAutocovMethod,
    bfmi,
    ess,
    ess_rhat,
    mcse,
    rhat,
    rstar

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

const _min_arviz_version = v"0.13.0"
const arviz = PyNULL()
const xarray = PyNULL()
const pandas = PyNULL()
const _rcParams = PyNULL()
const DEFAULT_SAMPLE_DIMS = Dimensions.key2dim((:chain, :draw))
const SUPPORTED_GROUPS = Symbol[]
const SUPPORTED_GROUPS_DICT = Dict{Symbol,Int}()

include("setup.jl")

# Load ArviZ once at precompilation time for docstringS
copy!(arviz, import_arviz())
check_needs_update(; update=false)
const _precompile_arviz_version = arviz_version()

function __init__()
    initialize_arviz()
    @require SampleChains = "754583d1-7fc4-4dab-93b5-5eaca5c9622e" begin
        include("samplechains.jl")
    end
    @require MCMCChains = "c7f686f2-ff18-58e9-bc7b-31028e88f75d" begin
        import .MCMCChains: Chains, sections
        include("mcmcchains.jl")
    end
    return nothing
end

include("utils.jl")
include("rcparams.jl")
include("xarray.jl")
include("conversions.jl")
include("plots.jl")

end # module
