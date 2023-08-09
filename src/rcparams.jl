@doc LazyHelp(arviz, "rcParams") const rcParams = PythonCall.pynew()

@doc LazyHelp(arviz, "rc_context") function rc_context(args...; kwargs...)
    return arviz.rc_context(args...; kwargs...)
end
