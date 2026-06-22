# Scatterplot all variables against each other

Plot all variables against each other in the dataset.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_pair(
    data;
    var_names=["mu", "theta", "tau"],
    coords=Dict("school" => ["Choate", "Deerfield"]),
)
gcf()
```

See [`plot_pair`](@ref).
