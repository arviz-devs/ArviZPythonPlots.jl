# ESS comparison

Full ESS (either local or quantile) comparison between different models.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

c = load_example_data("centered_eight")
n = load_example_data("non_centered_eight")
pc = plot_ess(Dict("Centered" => c, "Non Centered" => n))
gcf()
```

See [`plot_ess`](@ref).
