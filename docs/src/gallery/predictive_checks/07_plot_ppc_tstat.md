# Test statistics

T-statistic for the observed data and posterior predictive data.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_ppc_tstat(data; t_stat="median")
gcf()
```

See [`plot_ppc_tstat`](@ref).

See also the EABM chapter on [Posterior predictive checks with summary statistics](https://arviz-devs.github.io/EABM/Chapters/Prior_posterior_predictive_checks.html#using-summary-statistics).
