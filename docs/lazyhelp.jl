using Documenter, Markdown, PythonCall

# adapted from https://github.com/AtelierArith/Kyulacs.jl for PythonCall
# MIT License
# Copyright (c) 2022 Satoshi Terasaki <terasakisatoshi.math@gmail.com> and contributors

function get_signature(f)
    inspect = pyimport("inspect")
    try
        return pyconvert(String, inspect.signature(f))
    catch e
        return ""
    end
end

function gendocstr(h::LazyHelp)
    o = h.o
    for k in h.keys
        o = pygetattr(o, k)
    end
    fname = pyhasattr(o, "__name__") ? pyconvert(String, o.__name__) : ""
    sig = pyhasattr(o, "__call__") ? get_signature(o) : ""
    fdoc = pyhasattr(o, "__doc__") ? pyconvert(String, o.__doc__) : ""

    if isnothing(fdoc)
        return """
        $(fname)$(sig)
        """
    else
        return """
        $(fdoc)
        """
    end
end

function Documenter.Writers.HTMLWriter.mdconvert(
    h::LazyHelp,
    parent;
    kwargs...,
)
    s = gendocstr(h)
    # quote docstring `s` to prevent changing display result
    m = Markdown.parse(
        """
        ```
        $s
        ```
        """,
    )
    Documenter.Writers.HTMLWriter.mdconvert(m, parent; kwargs...)
end

Documenter.Utilities.MDFlatten.mdflatten(::IOBuffer, ::LazyHelp, ::Markdown.MD) = nothing
