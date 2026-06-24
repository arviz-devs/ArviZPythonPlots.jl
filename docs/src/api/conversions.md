# [Input conversions](@id conversions)

Our plotting functions forward their documented arguments to the underlying Python functions, where necessary transparently converting acceptable Julia types to the following corresponding Python types.

## `DataTree` arguments

Wherever a Python function accepts a `DataTree`, pass one of:

  - [`InferenceObjects.InferenceData`](@extref)
  - [`InferenceObjects.Dataset`](@extref)
  - [`DimensionalData.AbstractDimStack`](@extref DimensionalData stacks)

These are transparently converted to a Python `xarray.DataTree`.

!!! compat "Behavior change in ArviZPythonPlots 0.2"
    Pre-1.0 `arviz` used to auto-convert other inputs internally — bare numeric arrays, `NamedTuple`s of arrays, raw `Dict`s of arrays.
    If you have one of these looser types, convert it to one of the above `DataTree`-like types explicitly first, e.g. with [`InferenceObjects.convert_to_inference_data`](@extref).

## `dict of {str: DataTree}` arguments (multi-model comparison)

Functions whose docstring also documents a dict-of-`DataTree` form (e.g. [`plot_dist`](@ref), [`plot_forest`](@ref), [`combine_plots`](@ref)) additionally accept an `AbstractDict` whose values are each one of the `DataTree`-like types above; the keys become model names.
[`plot_forest`](@ref)/[`plot_ridge`](@ref) also accept a plain `Vector`/`Tuple` of such values, naming them positionally (`"model1"`, `"model2"`, ...).

## `DataArray` arguments

Wherever a docstring documents an argument as a raw `xarray.DataArray` (e.g. [`plot_pair_focus`](@ref)'s `focus_var`), pass a [`DimensionalData.AbstractDimArray`](@extref DimensionalData dimarrays); its dimension names and coordinates are preserved in the conversion.

## Result-object arguments

A few functions take a specific Python type produced by another `arviz` function rather than a `DataTree`:

  - [`plot_khat`](@ref) accepts the result of [`PosteriorStats.loo`](@extref) (a [`PosteriorStats.PSISLOOResult`](@extref)).
  - [`plot_compare`](@ref) accepts the result of [`PosteriorStats.compare`](@extref) (a [`PosteriorStats.ModelComparisonResult`](@extref)).

## Everything else

Arguments not covered above (`var_names`, `coords`, `backend`, etc.) are converted generically:
  - `Symbol`s become Python `str`s.
  - `NamedTuple`/`Dict` become Python `dict`s.
  - `Vector`/`Tuple` become Python `list`/`tuple`s.
  - numeric arrays become NumPy arrays.

A `PythonCall.Py` object is always passed through unchanged, so you can build an argument with `arviz`/`arviz_plots`/`xarray` Python calls directly if needed.
