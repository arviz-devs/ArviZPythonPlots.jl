
for f in _PLOT_FUNCTIONS
    @eval @forwardplotfun $f
end

function convert_arguments(::typeof(plot_elpd), data, args...; kwargs...)
    dict = OrderedDict(
        k => v isa AbstractELPDResult ? v : convert_to_inference_data(v) for
        (k, v) in pairs(data)
    )
    return tuple(dict, args...), kwargs
end

for f in (
    :plot_autocorr,
    :plot_bf,
    :plot_ess,
    :plot_mcse,
    :plot_pair,
    :plot_parallel,
    :plot_posterior,
    :plot_trace,
    :plot_violin,
)
    @eval begin
        function convert_arguments(::typeof($(f)), data, args...; kwargs...)
            idata = convert_to_inference_data(data; group=:posterior)
            return tuple(idata, args...), kwargs
        end
    end
end

function convert_arguments(::typeof(plot_energy), data, args...; kwargs...)
    dataset = convert_to_dataset(data; group=:sample_stats)
    return tuple(dataset, args...), kwargs
end

function convert_arguments(
    ::typeof(plot_lm), y, _idata=nothing, args...; idata=nothing, kwargs...
)
    if _idata !== nothing
        idata = convert_to_inference_data(_idata)
    elseif idata !== nothing
        idata = convert_to_inference_data(idata)
    else
        idata = nothing
    end
    return tuple(y, idata, args...), kwargs
end

for f in (:plot_density, :plot_forest, :plot_rank)
    @eval begin
        function convert_arguments(
            ::typeof($(f)), data, args...; transform=identity, group=:posterior, kwargs...
        )
            tdata = transform(data)
            dataset = convert_to_dataset(tdata; group)
            return tuple(dataset, args...), kwargs
        end
    end
end

for f in (:plot_density, :plot_forest)
    @eval begin
        function convert_arguments(
            ::typeof($(f)),
            data::Union{AbstractVector,Tuple},
            transform=identity,
            group=:posterior,
            args...;
            kwargs...,
        )
            tdata = transform(data)
            datasets = map(tdata) do datum
                return convert_to_dataset(datum; group)
            end
            return tuple(datasets, args...), kwargs
        end
        function convert_arguments(
            ::typeof($(f)),
            data::AbstractVector{<:Real},
            transform=identity,
            group=:posterior,
            args...;
            kwargs...,
        )
            tdata = transform(data)
            dataset = convert_to_dataset(tdata; group)
            return tuple(dataset, args...), kwargs
        end
    end
end
