# adapted from https://github.com/JuliaPy/PythonPlot.jl
# MIT License
# Copyright © 2013 by Steven G. Johnson

struct LazyHelp
    o # a Py or similar object supporting getindex with a __doc__ property
    keys::Tuple{Vararg{String}}
    LazyHelp(o) = new(o, ())
    LazyHelp(o, k::AbstractString) = new(o, (k,))
    LazyHelp(o, k1::AbstractString, k2::AbstractString) = new(o, (k1, k2))
    LazyHelp(o, k::Tuple{Vararg{AbstractString}}) = new(o, k)
end

function Base.show(io::IO, ::MIME"text/plain", h::LazyHelp)
    o = h.o
    for k in h.keys
        o = pygetattr(o, k)
    end
    if pyhasattr(o, "__doc__")
        print(io, pyconvert(String, o.__doc__))
    else
        print(io, "no Python docstring found for ", o)
    end
end

Base.show(io::IO, h::LazyHelp) = Base.show(io, "text/plain", h)

function Base.Docs.catdoc(hs::LazyHelp...)
    Base.Docs.Text() do io
        for h in hs
            Base.show(io, MIME"text/plain"(), h)
        end
    end
end
