# Forest plot

Default forest plot with marginal distribution summaries.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_forest(data; var_names=["home", "atts", "defs"])
gcf()
```

See [`plot_forest`](@ref).
