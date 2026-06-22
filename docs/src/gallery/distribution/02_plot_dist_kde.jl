# Posterior KDEs

KDE plot of the variable `mu` from the centered eight model. `sample_dims` restricts the KDE
computation to the `draw` dimension only.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_dist(data; kind="kde", var_names=["mu"], sample_dims=["draw"])
pc.add_title("KDE of μ by Chain (Centered Eight)")
gcf()
```

See [`plot_dist`](@ref).

See also the EABM chapter on [Visualization of Random Variables with ArviZ](https://arviz-devs.github.io/EABM/Chapters/Distributions.html#distributions-in-arviz).
