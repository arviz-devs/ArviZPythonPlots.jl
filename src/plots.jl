
for f in _PLOT_FUNCTIONS
    @eval @forwardplotfun $f
end

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
        function convert_arguments(::typeof($(f)), data, args...; kwargs...)
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
            "`$f` is not one of this package's exported plot functions and is not an `arviz` callable",
        ),
    )
    return getproperty(arviz, name)
end

function convert_arguments(::typeof(combine_plots), data, plot_list, args...; kwargs...)
    idata = convert_to_inference_data(data; group=:posterior)
    new_plot_list = [(_arviz_plotfun(f), kw) for (f, kw) in plot_list]
    return tuple(idata, new_plot_list, args...), kwargs
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
        function convert_arguments(::typeof($(f)), data, args...; kwargs...)
            idata = convert_to_inference_data(data; group=:posterior_predictive)
            return tuple(idata, args...), kwargs
        end
    end
end

function convert_arguments(::typeof(plot_energy), data, args...; kwargs...)
    idata = convert_to_inference_data(data; group=:sample_stats)
    return tuple(idata, args...), kwargs
end

# functions that also accept a dict/vector of models for multi-model comparison
# (a `NamedTuple` already means "one model's variables" per `convert_to_inference_data`,
# so multi-model dispatch is intentionally restricted to `AbstractDict`)
for f in (:plot_dist, :plot_ess, :plot_forest, :plot_ridge)
    @eval begin
        function convert_arguments(
            ::typeof($(f)), data::AbstractDict, args...; group=:posterior, kwargs...
        )
            dict = OrderedDict(
                string(k) => convert_to_inference_data(v; group) for (k, v) in pairs(data)
            )
            return tuple(dict, args...), kwargs
        end
    end
end

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
                "model$i" => convert_to_inference_data(datum; group) for
                (i, datum) in enumerate(data)
            )
            return tuple(dict, args...), kwargs
        end
    end
end
