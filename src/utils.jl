"""
    convert_arguments(f, args...; kwargs...) -> NTuple{2}

Convert arguments to the function `f` before calling.

This function is used primarily for pre-processing arguments within macros before sending
to arviz.
"""
convert_arguments(::Any, args...; kwargs...) = args, kwargs

"""
    convert_result(f, result, args...)

Convert result of the function `f` before returning.

This function is used primarily for post-processing outputs of arviz before returning.
The `args` are primarily used for dispatch.
"""
convert_result(f, result, args...) = result

function forwarddoc(f::Symbol)
    pydoc = "$(Docs.getdoc(getproperty(arviz, f)))"
    pydoc_sections = split(pydoc, '\n'; limit=2)
    if length(pydoc_sections) > 1
        summary, body = pydoc_sections
        summary *= "\n"
    else
        summary = ""
        body = pydoc
    end
    return """
    $summary

    !!! note
        This function is forwarded to Python's [`arviz.$(f)`](https://python.arviz.org/en/$(arviz_version())/api/generated/arviz.$(f).html).
        The docstring of that function is included below.
    ```
    $body
    ```
    """
end

forwardgetdoc(f::Symbol) = Docs.getdoc(getproperty(arviz, f))

"""
    @forwardfun f [forward_docs]
    @forwardfun(f, forward_docs=true)

Wrap a function `arviz.f` in `f`, forwarding its docstrings.

Use [`convert_arguments`](@ref) and [`convert_result`](@ref) to customize what is passed to
and returned from `f`.
"""
macro forwardfun(f, forward_docs=true)
    fesc = esc(f)
    fdoc = forwarddoc(f)
    ex = quote
        if $forward_docs
            @doc $fdoc $f
        end

        function $(fesc)(args...; kwargs...)
            args, kwargs = convert_arguments($(fesc), args...; kwargs...)
            result = arviz.$(f)(args...; kwargs...)
            return convert_result($(fesc), result)
        end
    end
    # make sure line number of methods are place where macro is called, not here
    _replace_line_number!(ex, __source__)
    return ex
end

"""
    @forwardplotfun f [forward_docs]
    @forwardplotfun(f, forward_docs=true)

Wrap a plotting function `arviz.f` in `f`, forwarding its docstrings.

Use [`convert_arguments`](@ref) and [`convert_result`](@ref) to customize what is passed to
and returned from `f`.
"""
macro forwardplotfun(f, forward_docs=true)
    fesc = esc(f)
    fdoc = forwarddoc(f)
    ex = quote
        if $forward_docs
            @doc $fdoc $f
        end

        function $(fesc)(args...; kwargs...)
            args, kwargs = convert_arguments($(fesc), args...; kwargs...)
            result = arviz.$(f)(args...; kwargs..., backend="matplotlib")
            return convert_result($(fesc), result)
        end
    end
    # make sure line number of methods are place where macro is called, not here
    _replace_line_number!(ex, __source__)
    return ex
end

function _replace_line_number!(ex, source)
    for i in eachindex(ex.args)
        if ex.args[i] isa LineNumberNode
            ex.args[i] = source
        elseif ex.args[i] isa Expr
            _replace_line_number!(ex.args[i], source)
        end
    end
end

# Convert python types to Julia types if possible
@inline frompytype(x) = x
@inline frompytype(x::PyObject) = PyAny(x)
frompytype(x::AbstractArray{PyObject}) = map(frompytype, x)
frompytype(x::AbstractArray{Any}) = map(frompytype, x)
frompytype(x::AbstractArray{<:AbstractArray}) = map(frompytype, x)

"""
    todataframes(df; index_name = nothing) -> DataFrames.DataFrame

Convert a Python `pandas.DataFrame` or `pandas.Series` into a `DataFrames.DataFrame`.

If `index_name` is not `nothing`, the index is converted into a column with `index_name`.
Otherwise, it is discarded.
"""
function todataframes(::Val{:DataFrame}, df::PyObject; index_name=nothing)
    initialize_pandas()
    col_vals = map(df.columns) do name
        series = py"$(df)[$(name)]"
        vals = series.values
        return Symbol(name) => frompytype(vals)
    end
    if index_name !== nothing
        index_vals = frompytype(df.index.values)
        col_vals = [Symbol(index_name) => index_vals; col_vals]
    end
    return DataFrames.DataFrame(col_vals)
end
function todataframes(::Val{:Series}, series::PyObject; kwargs...)
    initialize_pandas()
    colnames = map(i -> Symbol(frompytype(i)), series.index)
    colvals = map(x -> [frompytype(x)], series.values)
    return DataFrames.DataFrame(colvals, colnames)
end
function todataframes(df::PyObject; kwargs...)
    initialize_pandas()
    if pyisinstance(df, pandas.Series)
        return todataframes(Val(:Series), df; kwargs...)
    end
    return todataframes(Val(:DataFrame), df; kwargs...)
end

"""
    topandas(::Type{:DataFrame}, df; index_name = nothing) -> PyObject
    topandas(::Type{:Series}, df) -> PyObject
    topandas(::Val{:ELPDData}, df) -> PyObject

Convert a `DataFrames.DataFrame` to the specified pandas type.

If `index_name` is not `nothing`, the corresponding column is made the index of the
returned dataframe.
"""
function topandas(::Val{:DataFrame}, df; index_name=nothing)
    initialize_pandas()
    df = DataFrames.DataFrame(df)
    colnames = names(df)
    rowvals = map(Array, eachrow(df))
    pdf = pandas.DataFrame(rowvals; columns=colnames)
    index_name !== nothing && pdf.set_index(index_name; inplace=true)
    return pdf
end
function topandas(::Val{:Series}, df)
    initialize_pandas()
    df = DataFrames.DataFrame(df)
    rownames = names(df)
    colvals = Array(only(eachrow(df)))
    return pandas.Series(colvals, rownames)
end
