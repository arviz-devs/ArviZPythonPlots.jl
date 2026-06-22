# Rank and distribution plot

Two column layout with marginal distributions on the left and fractional ranks on the right.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("non_centered_eight")
pc = plot_rank_dist(data; var_names=["mu", "tau"])
gcf()
```

See [`plot_rank_dist`](@ref).
