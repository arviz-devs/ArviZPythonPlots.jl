
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
    :plot_mcse,
    :plot_pair,
    :plot_pair_focus,
    :plot_parallel,
    :plot_prior_posterior,
    :plot_psense_dist,
    :plot_psense_quantities,
    :plot_rank,
    :plot_rank_dist,
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
for f in (:plot_forest, :plot_ridge)
    @eval begin
        function convert_arguments(
            ::typeof($(f)), data, args...; transform=identity, group=:posterior, kwargs...
        )
            idata = convert_to_inference_data(transform(data); group)
            return tuple(idata, args...), kwargs
        end
        function convert_arguments(
            ::typeof($(f)),
            data::Union{AbstractVector,Tuple},
            args...;
            transform=identity,
            group=:posterior,
            kwargs...,
        )
            tdata = transform(data)
            dict = OrderedDict(
                "model$i" => convert_to_inference_data(datum; group) for
                (i, datum) in enumerate(tdata)
            )
            return tuple(dict, args...), kwargs
        end
    end
end
