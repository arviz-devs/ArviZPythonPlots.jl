# Convergence diagnostics distribution

Plot the distribution of ESS and R-hat.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("radon")
pc = plot_convergence_dist(data; var_names=["za_county"])
gcf()
```

See [`plot_convergence_dist`](@ref).
