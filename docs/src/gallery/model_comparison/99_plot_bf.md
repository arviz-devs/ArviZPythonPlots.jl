# Bayes factor

Compute the Bayes factor using the Savage-Dickey ratio.

We can apply this function when the null model is nested within the alternative. In other
words, when the null (`ref_val`) is a particular value of the model we are building (see
[here](https://statproofbook.github.io/P/bf-sddr.html)).

For other cases, computing the Bayes factor is not straightforward and requires more complex
methods. Instead of Bayes factors, we usually recommend Pareto-smoothed importance sampling
leave-one-out cross-validation (PSIS-LOO-CV). In ArviZ, you will find them as functions with
`loo` in their names.

```@example
using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("centered_eight")
pc = plot_bf(data, ["mu"])
gcf()
```

See [`plot_bf`](@ref).
