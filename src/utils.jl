"""
    convert_arguments(f, args...; kwargs...) -> NTuple{2}

Convert arguments to the function `f` before calling.

This function is used primarily for pre-processing arguments within macros before sending
to arviz.
"""
convert_arguments(::Any, args...; kwargs...) = args, kwargs

"""
    @forwardplotfun f

Wrap a plotting function `arviz.f` in `f`, forwarding its docstrings.

Use [`convert_arguments`](@ref)  to customize what is passed to `f`.
"""
macro forwardplotfun(f)
    fesc = esc(f)
    sf = string(f)
    ex = quote
        @doc LazyHelp(arviz, $sf) function $(fesc)(args...; kwargs...)
            args, kwargs = convert_arguments($(fesc), args...; kwargs...)
            pyargs = Iterators.map(topytype, args)
            pykwargs = (k => topytype(v) for (k, v) in pairs(kwargs))
            result = arviz.$(f)(pyargs...; pykwargs..., backend="matplotlib")
            return result
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

# Convert Julia types to suitable Python types
topytype(x::AbstractVector) = pylist(map(topytype, x))
topytype(x::AbstractVector{<:Real}) = Py(x).to_numpy()
topytype(x::AbstractArray{<:Real}) = Py(x).to_numpy()
topytype(x::Tuple) = pytuple(map(topytype, x))
topytype(x::AbstractDict) = pydict(topytype(k) => topytype(v) for (k, v) in pairs(x))
topytype(x::NamedTuple) = topytype(pairs(x))
topytype(x::Symbol) = pystr(x)
topytype(::Missing) = Py(NaN)
topytype(x) = Py(x)

"""
    topandas(::Type{:DataFrame}, table; index_name = nothing) -> Py

Convert a Tables-compatible table to the specified pandas type.

If `index_name` is not `nothing`, the corresponding column is made the index of the
returned dataframe.
"""
function topandas(::Val{:DataFrame}, table; index_name=nothing)
    # initialize_pandas()
    colnames = topytype(Tables.columnnames(table))
    rowvals = map(topytype ∘ values, Tables.namedtupleiterator(table))
    pdf = pandas.DataFrame(rowvals; columns=colnames)
    index_name !== nothing && pdf.set_index(index_name; inplace=true)
    return pdf
end
