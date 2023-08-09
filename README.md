# ArviZPythonPlots

[![docs](https://img.shields.io/badge/docs-ArviZ-blue.svg)](https://julia.arviz.org/ArviZPythonPlots)
[![Build Status](https://github.com/arviz-devs/ArviZPythonPlots.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/arviz-devs/ArviZPythonPlots.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/arviz-devs/ArviZPythonPlots.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/arviz-devs/ArviZPythonPlots.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
[![Powered by NumFOCUS](https://img.shields.io/badge/powered%20by-NumFOCUS-orange.svg?style=flat&colorA=E1523D&colorB=007D8A)](https://numfocus.org)

ArviZPythonPlots.jl provides PyPlot-compatible plotting functions for exploratory analysis of Bayesian models using [ArviZ.jl](https://julia.arviz.org/).
It uses ArviZPythonPlots.jl uses [PythonCall.jl](https://github.com/cjdoris/PythonCall.jl) to provide an interface to use the plotting functions in [Python ArviZ](https://python.arviz.org/) with Julia types.
It also re-exports all methods exported by both ArviZ.jl and [PythonPlot.jl](https://github.com/JuliaPy/PythonPlot.jl).

See the [documentation](https://julia.arviz.org/ArviZPythonPlots) for details.
