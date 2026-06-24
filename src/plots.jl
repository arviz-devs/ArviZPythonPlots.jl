
for f in _PLOT_FUNCTIONS
    @eval @forwardplotfun $f
end

# Faithful 1:1 Julia representations of a `DataTree`. arviz_plots dropped the auto-conversion
# legacy (pre-1.0) arviz used to do internally (accepting bare arrays, `NamedTuple`s, raw
# `Dict`s of arrays, etc.); for functions whose docstring documents `dt` as strictly
# `DataTree`/`dict of {str: DataTree}`, we don't reintroduce that convenience on the Julia
# side either, since Python's own function no longer supports it.
const _DataTreeLike = Union{InferenceData,Dataset,DimensionalData.AbstractDimStack}

# used to narrow the per-element type within dict/vector multi-model inputs, where the
# outer container's type alone doesn't constrain its values/elements
_idata_like(data::_DataTreeLike; group) = convert_to_inference_data(data; group)

# functions whose `dt` argument defaults to the `posterior` group
for f in (
    :plot_autocorr,
    :plot_bf,
    :plot_convergence_dist,
    :plot_dgof,
    :plot_dgof_dist,
    :plot_dist,
    :plot_ess,
    :plot_ess_evolution,
    :plot_forest,
    :plot_mcse,
    :plot_pair,
    :plot_pair_focus,
    :plot_parallel,
    :plot_prior_posterior,
    :plot_psense_dist,
    :plot_psense_quantities,
    :plot_rank,
    :plot_rank_dist,
    :plot_ridge,
    :plot_trace,
    :plot_trace_dist,
)
    @eval begin
        function convert_arguments(::typeof($(f)), data::_DataTreeLike, args...; kwargs...)
            idata = convert_to_inference_data(data; group=:posterior)
            return tuple(idata, args...), kwargs
        end
    end
end

# `combine_plots` takes a list of `(plotting_function, kwargs)` pairs forwarded to
# `arviz.combine_plots`; accept the exported Julia wrappers (e.g. `plot_rank`) here too,
# since `@forwardplotfun` always names a wrapper after the `arviz` function it calls
_arviz_plotfun(f::Py) = f
function _arviz_plotfun(f::Function)
    name = nameof(f)
    PythonCall.pyhasattr(arviz, string(name)) || throw(
        ArgumentError(
            "`$name` is not one of this package's exported plot functions and is not an `arviz` callable",
        ),
    )
    return getproperty(arviz, name)
end

function convert_arguments(
    ::typeof(combine_plots), data::_DataTreeLike, plot_list, args...; kwargs...
)
    idata = convert_to_inference_data(data; group=:posterior)
    new_plot_list = [(_arviz_plotfun(f), kw) for (f, kw) in plot_list]
    return tuple(idata, new_plot_list, args...), kwargs
end
function convert_arguments(
    ::typeof(combine_plots),
    data::AbstractDict,
    plot_list,
    args...;
    group=:posterior,
    kwargs...,
)
    dict = OrderedDict(string(k) => _idata_like(v; group) for (k, v) in pairs(data))
    new_plot_list = [(_arviz_plotfun(f), kw) for (f, kw) in plot_list]
    return tuple(dict, new_plot_list, args...), kwargs
end

# functions whose `dt` argument defaults to the `posterior_predictive` group
for f in (
    :plot_ecdf_pit,
    :plot_lm,
    :plot_loo_interval,
    :plot_loo_pit,
    :plot_ppc_censored,
    :plot_ppc_dist,
    :plot_ppc_dist_pit,
    :plot_ppc_interval,
    :plot_ppc_pava,
    :plot_ppc_pava_residuals,
    :plot_ppc_pit,
    :plot_ppc_rootogram,
    :plot_ppc_tstat,
)
    @eval begin
        function convert_arguments(::typeof($(f)), data::_DataTreeLike, args...; kwargs...)
            idata = convert_to_inference_data(data; group=:posterior_predictive)
            return tuple(idata, args...), kwargs
        end
    end
end

function convert_arguments(::typeof(plot_energy), data::_DataTreeLike, args...; kwargs...)
    idata = convert_to_inference_data(data; group=:sample_stats)
    return tuple(idata, args...), kwargs
end

# functions whose docstring also documents a `dict of {str: DataTree}` form for multi-model
# comparison (a dimension `"model"` is generated from the dict keys). `plot_prior_posterior`
# documents the same dict form but its implementation accesses `dt.prior`/`dt.posterior`
# directly without the `isinstance(dt, dict)` branch the others route through
# (`arviz_plots/plots/utils.py`'s `process_group_variables_coords`), so it's omitted here.
for f in (:plot_dist, :plot_ess, :plot_ess_evolution, :plot_forest, :plot_mcse, :plot_ridge)
    @eval begin
        function convert_arguments(
            ::typeof($(f)), data::AbstractDict, args...; group=:posterior, kwargs...
        )
            dict = OrderedDict(string(k) => _idata_like(v; group) for (k, v) in pairs(data))
            return tuple(dict, args...), kwargs
        end
    end
end

# `plot_forest`/`plot_ridge` don't document a list form, but a `Vector`/`Tuple` of models is
# an unambiguous faithful `dict of {str: DataTree}` representation once each element is
# itself `_DataTreeLike`, so it's kept as a convenience for naming models positionally
for f in (:plot_forest, :plot_ridge)
    @eval begin
        function convert_arguments(
            ::typeof($(f)),
            data::Union{AbstractVector,Tuple},
            args...;
            group=:posterior,
            kwargs...,
        )
            dict = OrderedDict(
                "model$i" => _idata_like(datum; group) for (i, datum) in enumerate(data)
            )
            return tuple(dict, args...), kwargs
        end
    end
end
