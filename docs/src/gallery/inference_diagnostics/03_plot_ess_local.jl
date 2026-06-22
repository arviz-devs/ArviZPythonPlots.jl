# ESS local

Faceted local ESS plot.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_ess(data; kind="local", rug=true)
gcf()
```

See [`plot_ess`](@ref).
