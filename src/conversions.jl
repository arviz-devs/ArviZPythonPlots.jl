function PythonCall.Py(d::PSISLOOResult)
    estimates = elpd_estimates(d)
    pointwise = elpd_estimates(d; pointwise=true)
    psis_result = d.psis_result
    ds = convert_to_dataset((loo_i=pointwise.elpd, pareto_shape=pointwise.pareto_shape))
    pyds = PythonCall.Py(ds)
    entries = (
        elpd_loo=estimates.elpd,
        se=estimates.se_elpd,
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
        se=estimates.se_elpd,
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

function rekey(nt::NamedTuple, old_new_keys::Pair...)
    keys_new = replace(keys(nt), old_new_keys...)
    return NamedTuple{keys_new}(values(nt))
end

function PythonCall.Py(mc::ModelComparisonResult)
    table = Tables.columntable(mc)
    se_pairs = (:se_elpd => :se, :se_elpd_diff => :dse)
    est_pairs = if eltype(mc.elpd_result) <: PSISLOOResult
        (:elpd => :elpd_loo, :p => :p_loo)
    elseif eltype(mc.elpd_result) <: WAICResult
        (:elpd => :elpd_waic, :p => :p_waic)
    end
    nrows = Tables.rowcount(table)
    new_cols = (warning=fill(false, nrows), scale=fill("log", nrows))
    table_new = merge(rekey(table, est_pairs..., se_pairs...), new_cols)
    pdf = topandas(Val(:DataFrame), table_new; index_name="name")
    return pdf
end
