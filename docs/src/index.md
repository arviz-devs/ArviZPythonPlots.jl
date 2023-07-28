# ArviZPythonPlots.jl

ArviZPythonPlots.jl provides PyPlot-compatible plotting functions for exploratory analysis of Bayesian models using [ArviZ.jl](https://julia.arviz.org/).
It provides an interface to use the plotting functions in [Python ArviZ](https://python.arviz.org/) with Julia types.
It also re-exports all methods exported by both ArviZ.jl and [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl).

For details, see the [Example Gallery](@ref) or the [API](@ref api).

## [Installation](@id installation)

To install ArviZPythonPlots.jl, we first need to install Python ArviZ.
To use with the default Python environment, first [install Python ArviZ](https://python.arviz.org/en/latest/getting_started/Installation.html).
From the Julia REPL, type `]` to enter the Pkg REPL mode and run

```
pkg> add ArviZPythonPlots
```

To install ArviZPythonPlots.jl with its Python dependencies in Julia's private conda environment, in the console run

```console
PYTHON="" julia -e 'using Pkg; Pkg.add("PyCall"); Pkg.build("PyCall"); Pkg.add("ArviZPythonPlots")'
```

For specifying other Python versions, see the [PyCall documentation](https://github.com/JuliaPy/PyCall.jl).

## [Known Issues](@id knownissues)

ArviZPythonPlots.jl uses [PyCall.jl](https://github.com/JuliaPy/PyCall.jl) to wrap Python ArviZ.
At the moment, Julia segfaults if Numba is imported, which Python ArviZ does if it is available.
For the moment, the workaround is to [specify a Python version](https://github.com/JuliaPy/PyCall.jl#specifying-the-python-version) that doesn't have Numba installed.
See [this issue](https://github.com/JuliaPy/PyCall.jl/issues/220) for more details.
