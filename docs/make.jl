using ArviZPythonPlots, Documenter, Literate, DocumenterInterLinks
using ArviZPythonPlots: LazyHelp

include("lazyhelp.jl")
include("gallery.jl")

const GALLERY_CATEGORIES = [
    "distribution" => "Distribution",
    "posterior_comparison" => "Posterior comparison",
    "inference_diagnostics" => "Inference diagnostics",
    "predictive_checks" => "Predictive checks",
    "prior_and_likelihood_sensitivity_checks" => "Prior and likelihood sensitivity checks",
    "model_comparison" => "Model comparison",
    "sbc" => "Simulation based calibration",
    "mixed" => "Mixed",
]

prettyurls = haskey(ENV, "CI")

gallery_page = build_gallery!(
    joinpath(@__DIR__, "gallery"),
    joinpath(@__DIR__, "src", "gallery"),
    GALLERY_CATEGORIES,
    prettyurls,
)

links = InterLinks(
    "PosteriorStats" => "https://julia.arviz.org/PosteriorStats/stable/",
    "InferenceObjects" => "https://julia.arviz.org/InferenceObjects/stable/",
    "DimensionalData" => "https://rafaqz.github.io/DimensionalData.jl/stable/",
)

makedocs(;
    modules=[ArviZPythonPlots],
    repo=Remotes.GitHub("arviz-devs", "ArviZPythonPlots.jl"),
    sitename="ArviZPythonPlots.jl",
    pages=[
        "Home" => "index.md",
        gallery_page,
        "API" => [
            hide("api/index.md"),
            "Input conversions" => "api/conversions.md",
            "Plotting styles" => "api/style.md",
            "rcParams" => "api/rcparams.md",
            "Plotting functions" => "api/plots.md",
        ],
    ],
    checkdocs=:exports,
    format=Documenter.HTML(;
        prettyurls=prettyurls,
        sidebar_sitename=false,
        canonical="stable",
        size_threshold=300_000,
        assets=["assets/gallery.css"],
    ),
    doctest=false,
    linkcheck=true,
    plugins=[links],
)

copy_gallery_covers!(
    joinpath(@__DIR__, "gallery"),
    joinpath(@__DIR__, "build", "gallery"),
    GALLERY_CATEGORIES,
    prettyurls,
)

deploydocs(;
    repo="github.com/arviz-devs/ArviZPythonPlots.jl.git",
    devbranch="main",
    push_preview=true,
)
