# ESS evolution

Faceted plot with ESS "bulk" and "tail" for each variable.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess_evolution(data)
gcf()
```

See [`plot_ess_evolution`](@ref).
