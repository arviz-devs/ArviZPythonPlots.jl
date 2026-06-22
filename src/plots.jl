
for f in _PLOT_FUNCTIONS
    @eval @forwardplotfun $f
end

# functions whose `dt` argument defaults to the `posterior` group
for f in (
    :combine_plots,
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
