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

# warning: piracy on the high seas 🏴‍☠️
function Base.Docs.parsedoc(d::Base.Docs.DocStr)
    if d.object isa LazyHelp
        s = gendocstr(d.object)
        # quote docstring `s` to prevent changing display result
        md = Markdown.parse("""
                           ```
                           $s
                           ```
                           """)
        d.object = md
    end
    # copied from base Julia's implementation
    if d.object === nothing
        md = Base.Docs.formatdoc(d)
        md.meta[:module] = d.data[:module]
        md.meta[:path]   = d.data[:path]
        d.object = md
    end
    return d.object
end
