function PythonCall.Py(d::PSISLOOResult)
    estimates = elpd_estimates(d)
    pointwise = elpd_estimates(d; pointwise=true)
    psis_result = d.psis_result
    ds = convert_to_dataset((elpd_i=pointwise.elpd, pareto_k=pointwise.pareto_shape))
    pyds = PythonCall.Py(ds)
    n_samples = psis_result.nchains * psis_result.ndraws
    good_k = min(1 - inv(log10(n_samples)), 0.7)

    return arviz.ELPDData(;
        kind="loo",
        elpd=estimates.elpd,
        se=estimates.se_elpd,
        p=estimates.p,
        n_samples,
        n_data_points=psis_result.nparams,
        scale="log",
        warning=false,
        good_k,
        elpd_i=pyds.elpd_i,
        pareto_k=pyds.pareto_k,
    )
end

function rekey(nt::NamedTuple, old_new_keys::Pair...)
    keys_new = replace(keys(nt), old_new_keys...)
    return NamedTuple{keys_new}(values(nt))
end

function PythonCall.Py(mc::ModelComparisonResult)
    table = Tables.columntable(mc)
    se_pairs = (:se_elpd => :se, :se_elpd_diff => :dse)
    table_new = rekey(table, se_pairs...)
    n = length(table_new.name)
    # `PosteriorStats.ModelComparisonResult` doesn't compute these; arviz_stats's own
    # `compare()` DataFrame has them, and `plot_compare` expects the columns to exist
    table_new = merge(
        table_new, (p_worse=fill(NaN, n), diag_diff=fill("", n), diag_elpd=fill("", n))
    )
    pdf = topandas(Val(:DataFrame), table_new; index_name="name")
    return pdf
end
