using ArviZPyPlot, Documenter

makedocs(;
    modules=[ArviZPyPlot],
    sitename="ArviZPyPlot.jl",
    pages=[
        "Home" => "index.md",
        "Examples gallery" => "examples.md",
        "API" => [
            hide("api/index.md"),
            "Plots" => "api/plots.md",
        ],
    ],
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=haskey(ENV, "CI"),
        sidebar_sitename=false,
        canonical="stable",
    ),
    linkcheck=true,
)

deploydocs(; repo="github.com/arviz-devs/ArviZPyPlot.jl.git", devbranch="main", push_preview=true)
