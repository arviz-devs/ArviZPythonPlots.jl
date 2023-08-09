function PythonCall.Py(d::PSISLOOResult)
    estimates = elpd_estimates(d)
    pointwise = elpd_estimates(d; pointwise=true)
    psis_result = d.psis_result
    ds = convert_to_dataset((loo_i=pointwise.elpd, pareto_shape=pointwise.pareto_shape))
    pyds = PythonCall.Py(ds)
    entries = (
        elpd_loo=estimates.elpd,
        se=estimates.elpd_mcse,
        p_loo=estimates.p,
        n_samples=psis_result.nchains * psis_result.ndraws,
        n_data_points=psis_result.nparams,
        warning=false,
        loo_i=pyds.loo_i,
        pareto_k=pyds.pareto_shape,
        scale="log",
    )
    data = pylist(values(entries))
    index = pylist(map(pystr, keys(entries)))
    return arviz.stats.ELPDData(; data, index)
end

function PythonCall.Py(d::WAICResult)
    estimates = elpd_estimates(d)
    pointwise = elpd_estimates(d; pointwise=true)
    ds = convert_to_dataset((waic_i=pointwise.elpd,))
    pyds = PythonCall.Py(ds)
    entries = (
        elpd_waic=estimates.elpd,
        se=estimates.elpd_mcse,
        p_waic=estimates.p,
        n_samples="unknown",
        n_data_points=length(pointwise.elpd),
        warning=false,
        waic_i=pyds.waic_i,
        scale="log",
    )
    data = pylist(values(entries))
    index = pylist(map(pystr, keys(entries)))
    return arviz.stats.ELPDData(; data, index)
end

function PythonCall.Py(mc::ModelComparisonResult)
    df = DataFrame(mc)
    rename!(df, :elpd_mcse => :se, :elpd_diff_mcse => :dse)
    if eltype(mc.elpd_result) <: PSISLOOResult
        rename!(df, :elpd => :elpd_loo, :p => :p_loo)
    elseif eltype(mc.elpd_result) <: WAICResult
        rename!(df, :elpd => :elpd_waic, :p => :p_waic)
    end
    df.warning = map(_ -> false, df.name)
    df.scale = map(_ -> "log", df.name)
    pdf = topandas(Val(:DataFrame), df; index_name="name")
    return pdf
end
