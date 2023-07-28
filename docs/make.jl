using ArviZPyPlot, Documenter

makedocs(;
    modules=[ArviZPyPlot],
    sitename="ArviZPyPlot.jl",
    pages=[
        "Home" => "index.md",
        "Example Gallery" => ["Matplotlib" => "mpl_examples.md"],
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

