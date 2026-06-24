# [Input conversions](@id conversions)

ArviZPythonPlots.jl's wrapped plotting functions (e.g. [`plot_dist`](@ref), [`plot_forest`](@ref), [`combine_plots`](@ref)) forward each function's documented argument types to the underlying Python `arviz`/`arviz_plots` function.
Rather than duplicating every function's docstring with Julia-specific type information, the Julia-side conversions follow a few general rules described here.

## `DataTree` arguments

Wherever a function's Python docstring documents its `dt` argument as a `DataTree`, pass one of:

  - [`InferenceObjects.InferenceData`](@extref)
  - [`InferenceObjects.Dataset`](@extref)
  - [`DimensionalData.AbstractDimStack`](@extref DimensionalData stacks)

These convert to a Python `xarray.DataTree` automatically.

!!! compat "Behavior change in ArviZPythonPlots 0.2"
    Pre-1.0 `arviz` used to auto-convert other inputs internally — bare numeric arrays, `NamedTuple`s of arrays, raw `Dict`s of arrays.
    Since `arviz`/`arviz_plots` 1.0 dropped that conversion themselves, these are **not** auto-promoted here either.
    If you have one of these looser types, convert it explicitly first, e.g. with `InferenceObjects.convert_to_inference_data`.

## `dict of {str: DataTree}` arguments (multi-model comparison)

Functions whose docstring also documents a dict-of-`DataTree` form (e.g. [`plot_dist`](@ref), [`plot_forest`](@ref), [`combine_plots`](@ref)) additionally accept an `AbstractDict` whose values are each one of the `DataTree`-like types above; the keys become model names.
[`plot_forest`](@ref)/[`plot_ridge`](@ref) also accept a plain `Vector`/`Tuple` of such values, naming them positionally (`"model1"`, `"model2"`, ...).

## `DataArray` arguments

Wherever a docstring documents an argument as a raw `xarray.DataArray` (not `DataTree`) — e.g. [`plot_pair_focus`](@ref)'s `focus_var` — pass a [`DimensionalData.AbstractDimArray`](@extref DimensionalData dimarrays); its dimension names and coordinates are preserved in the conversion.

## Result-object arguments

A few functions take a specific Python type produced by another `arviz` function rather than a `DataTree`:

  - [`plot_khat`](@ref) takes whatever [`PosteriorStats.loo`](@extref) returns (a [`PosteriorStats.PSISLOOResult`](@extref)); it converts to Python's `arviz.ELPDData`.
  - [`plot_compare`](@ref) takes whatever [`PosteriorStats.compare`](@extref) (a `PosteriorStats.ModelComparisonResult`) returns; it converts to the same `pandas.DataFrame` shape `arviz_stats.compare()` produces.

## Everything else

Arguments not covered above (`var_names`, `coords`, `backend`, etc.) are converted generically: `Symbol`s become Python `str`s, `NamedTuple`/`Dict` become Python `dict`s, `Vector`/`Tuple` become Python `list`/`tuple`s, and numeric arrays become NumPy arrays.
A `PythonCall.Py` object is always passed through unchanged, so you can build an argument with `arviz`/`arviz_plots`/`xarray` Python calls directly if needed.
