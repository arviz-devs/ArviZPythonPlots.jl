@doc LazyHelp(arviz, "rcParams")
const rcParams = PythonCall.pynew()

@doc LazyHelp(arviz, "rc_context")
rc_context(args...; kwargs...) = arviz.rc_context(args...; kwargs...)
