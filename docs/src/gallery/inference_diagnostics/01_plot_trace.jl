# Trace plot

Faceted plot with MCMC traces for each variable.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_trace(data)
pc.add_title("MCMC Sampling Traces: Centered Eight Model")
gcf()
```

See [`plot_trace`](@ref).
