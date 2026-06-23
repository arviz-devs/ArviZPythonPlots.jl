# Replaces DemoCards.jl: builds `gallery/<category>/<id>.md` pages from the Literate.jl
# scripts in `docs/gallery/`, a hand-rolled thumbnail-grid index page, and copies
# Documenter's own rendered example images into stable-named cover thumbnails after the
# build (Documenter's `@example`-block output filenames are not stable across builds).

jl_files(dir) = sort(filter(f -> endswith(f, ".jl"), readdir(dir)))

function gallery_sources(src_root, categories)
    examples = NamedTuple{(:category, :id),Tuple{String,String}}[]
    for (category, _) in categories
        for file in jl_files(joinpath(src_root, category))
            push!(examples, (; category, id=first(splitext(file))))
        end
    end
    return examples
end

function parse_frontmatter(path)
    lines = readlines(path)
    lines[1] == "# ---" || error("expected frontmatter at the top of $path")
    close_idx = findnext(==("# ---"), lines, 2)
    close_idx === nothing && error("unterminated frontmatter in $path")
    fields = Dict{String,String}()
    for line in lines[2:(close_idx - 1)]
        m = match(r"^# (\w+): \"(.*)\"$", line)
        m === nothing && error("could not parse frontmatter line in $path: $line")
        key, value = m.captures
        fields[key] = replace(value, "\\\"" => "\"")
    end
    haskey(fields, "title") || error("missing `title` frontmatter key in $path")
    return (; title=fields["title"], description=get(fields, "description", ""))
end

# The link/description are real Markdown (not raw HTML) so Documenter rewrites the `.md`
# link (respecting `prettyurls`) and renders any Markdown the `description:` frontmatter
# contains (e.g. an embedded `[`fn`](@ref)`); the cover `<img>` is raw HTML because
# Documenter validates Markdown image links exist on disk *before* the `@example` blocks
# that produce them run (and before `copy_gallery_covers!` runs, which is after the whole
# build) — raw HTML isn't checked, so it can point at a file that doesn't exist yet.
function gallery_card(src_root, category, id)
    fm = parse_frontmatter(joinpath(src_root, category, "$id.jl"))
    href = joinpath(category, "$id.md")
    cover = joinpath("covers", "$id.png")
    return """
    ```@raw html
    <div class="gallery-card">
    <img src="$cover" alt="$(fm.title)">
    ```
    **[$(fm.title)]($href)**

    $(fm.description)
    ```@raw html
    </div>
    ```
    """
end

function gallery_index_markdown(src_root, categories)
    io = IOBuffer()
    println(io, "# Examples gallery")
    println(io)
    println(
        io,
        "Examples of the plotting functions exported by ArviZPythonPlots.jl, ported from the",
    )
    println(
        io,
        "[arviz-plots gallery](https://python.arviz.org/projects/plots/en/latest/gallery/index.html).",
    )
    for (category, title) in categories
        println(io)
        println(io, "## $title")
        println(io)
        println(io, "```@raw html")
        println(io, "<div class=\"gallery-grid\">")
        println(io, "```")
        for file in jl_files(joinpath(src_root, category))
            print(io, gallery_card(src_root, category, first(splitext(file))))
            println(io)
        end
        println(io, "```@raw html")
        println(io, "</div>")
        println(io, "```")
    end
    return String(take!(io))
end

# Generates `out_root/<category>/<id>.md` and `out_root/index.md`, and returns the
# `pages=`-ready entry for `makedocs`. Every example page is registered via `hide(...)` (the
# same helper already used for the API section below) so it builds deterministically without
# adding sidebar nav depth, matching today's flat single-entry sidebar behavior.
function build_gallery!(src_root, out_root, categories)
    for (category, _) in categories
        dir = joinpath(src_root, category)
        outdir = joinpath(out_root, category)
        for file in jl_files(dir)
            Literate.markdown(joinpath(dir, file), outdir)
        end
    end
    mkpath(out_root)
    write(joinpath(out_root, "index.md"), gallery_index_markdown(src_root, categories))
    hidden_pages = [
        hide(joinpath("gallery", e.category, "$(e.id).md")) for
        e in gallery_sources(src_root, categories)
    ]
    return "Examples gallery" => vcat(joinpath("gallery", "index.md"), hidden_pages)
end

# Each example's `@example` block already renders its own plot inline (via the script's
# final `gcf()`); reuse that rendered image as the index page's cover thumbnail instead of
# executing every example a second time just to generate one.
function copy_gallery_covers!(src_root, build_root, categories)
    covers_dir = joinpath(build_root, "covers")
    mkpath(covers_dir)
    for example in gallery_sources(src_root, categories)
        dir = joinpath(build_root, example.category)
        matches = filter(
            f -> startswith(f, "$(example.id)-") && endswith(f, ".png"), readdir(dir)
        )
        length(matches) == 1 || error(
            "expected exactly one cover image candidate for $(example.id) in $dir, found $(length(matches))",
        )
        cp(
            joinpath(dir, only(matches)),
            joinpath(covers_dir, "$(example.id).png");
            force=true,
        )
    end
    return nothing
end
