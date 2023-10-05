using ArviZPythonPlots, Documenter
using ArviZPythonPlots: LazyHelp

include("lazyhelp.jl")

makedocs(;
    modules=[ArviZPythonPlots],
    repo=Remotes.GitHub("arviz-devs", "ArviZPythonPlots.jl"),
    sitename="ArviZPythonPlots.jl",
    pages=[
        "Home" => "index.md",
        "Examples gallery" => "examples.md",
        "API" => [
            hide("api/index.md"),
            "Plotting styles" => "api/style.md",
            "rcParams" => "api/rcparams.md",
            "Plotting functions" => "api/plots.md",
        ],
    ],
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=haskey(ENV, "CI"), sidebar_sitename=false, canonical="stable"
    ),
    doctest=false,
    linkcheck=true,
)

deploydocs(;
    repo="github.com/arviz-devs/ArviZPythonPlots.jl.git",
    devbranch="main",
    push_preview=true,
)
