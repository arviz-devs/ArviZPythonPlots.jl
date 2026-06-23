using ArviZPythonPlots, Documenter, DemoCards, DocumenterInterLinks
using ArviZPythonPlots: LazyHelp

include("lazyhelp.jl")

# generate the gallery pages (and thumbnail index) from the literate scripts in docs/gallery/
# (docs/gallery/index.md is the index page's template, with a `{{{democards}}}` placeholder)
gallery, postprocess_cb, gallery_assets = makedemos("gallery"; root=@__DIR__)

assets = String[]
isnothing(gallery_assets) || push!(assets, gallery_assets)

links = InterLinks("PosteriorStats" => "https://julia.arviz.org/PosteriorStats/stable/")

makedocs(;
    modules=[ArviZPythonPlots],
    repo=Remotes.GitHub("arviz-devs", "ArviZPythonPlots.jl"),
    sitename="ArviZPythonPlots.jl",
    pages=[
        "Home" => "index.md",
        gallery,
        "API" => [
            hide("api/index.md"),
            "Plotting styles" => "api/style.md",
            "rcParams" => "api/rcparams.md",
            "Plotting functions" => "api/plots.md",
        ],
    ],
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=haskey(ENV, "CI"),
        sidebar_sitename=false,
        canonical="stable",
        size_threshold=300_000,
        edit_link=nothing,
        assets=assets,
    ),
    doctest=false,
    linkcheck=true,
    plugins=[links],
)

postprocess_cb()

deploydocs(;
    repo="github.com/arviz-devs/ArviZPythonPlots.jl.git",
    devbranch="main",
    push_preview=true,
)
