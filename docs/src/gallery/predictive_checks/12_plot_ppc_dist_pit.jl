# Predictive check with ECDF and PIT Δ-ECDFs

Plot of the ECDF (right) of the PIT values (left) for samples from the posterior predictive
and observed data.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_ppc_dist_pit(data; kind="ecdf", var_names=["home_points", "away_points"])
gcf()
```

See [`plot_ppc_dist_pit`](@ref).

See also the EABM chapter on [Posterior predictive checks with PIT-ECDFs](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#pit-ecdfs).
