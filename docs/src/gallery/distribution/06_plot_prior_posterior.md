# Plot prior and posterior

Plot prior and posterior marginal distributions.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_prior_posterior(data; var_names="mu", kind="hist")
gcf()
```

See [`plot_prior_posterior`](@ref).
