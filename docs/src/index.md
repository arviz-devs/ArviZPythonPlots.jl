# ArviZPythonPlots.jl

ArviZPythonPlots.jl provides PyPlot-compatible plotting functions for exploratory analysis of Bayesian models using [ArviZ.jl](https://julia.arviz.org/).
It uses ArviZPythonPlots.jl uses [PythonCall.jl](https://github.com/cjdoris/PythonCall.jl) to provide an interface to use the plotting functions in [Python ArviZ](https://python.arviz.org/) with Julia types.
It also re-exports all methods exported by both ArviZ.jl and [PythonPlot.jl](https://github.com/JuliaPy/PythonPlot.jl).

For details, see the [Example Gallery](@ref) or the [API](@ref api).

## [Installation](@id installation)

To install ArviZPythonPlots.jl, we first need to install Python ArviZ.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run

```
pkg> add ArviZPythonPlots
```
