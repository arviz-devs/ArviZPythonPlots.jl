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

_htmlescape(s) = replace(s, "&" => "&amp;", "<" => "&lt;", ">" => "&gt;", "\"" => "&quot;")

# Mirrors Documenter's own `get_url`/`pretty_url` (HTMLWriter.jl) for a link from
# `gallery/index.md` to `gallery/<category>/<id>.md`, verified against real Documenter
# output for both `prettyurls` settings. Needed because the cover image's wrapping link must
# be raw HTML (see `gallery_card`), which Documenter does not rewrite itself.
example_url(prettyurls, category, id) = prettyurls ? "$category/$id/" : "$category/$id.html"

# The cover `<img>` and its wrapping link are raw HTML because Documenter validates Markdown
# image links exist on disk *before* the `@example` blocks that produce them run (and before
# `copy_gallery_covers!` runs, which is after the whole build) — raw HTML isn't checked, so
# it can point at a file that doesn't exist yet. A single link "stretched" over the whole
# card (as in the upstream arviz-plots gallery) makes the image and title click the same way.
# The description stays real Markdown, inside a raw-HTML overlay div, so it still renders any
# Markdown the `description:` frontmatter contains (e.g. an embedded `[`fn`](@ref)`).
function gallery_card(src_root, category, id, prettyurls)
    fm = parse_frontmatter(joinpath(src_root, category, "$id.jl"))
    url = example_url(prettyurls, category, id)
    cover = joinpath("covers", "$id.png")
    title = _htmlescape(fm.title)
    return """
    ```@raw html
    <div class="gallery-card">
    <div class="gallery-card-image">
    <img src="$cover" alt="$title">
    <div class="gallery-card-overlay">
    ```
    $(fm.description)
    ```@raw html
    </div>
    </div>
    <div class="gallery-card-footer">$title</div>
    <a class="gallery-card-link" href="$url" aria-label="$title"></a>
    </div>
    ```
    """
end

function gallery_index_markdown(src_root, categories, prettyurls)
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
            print(io, gallery_card(src_root, category, first(splitext(file)), prettyurls))
            println(io)
        end
        println(io, "```@raw html")
        println(io, "</div>")
        println(io, "```")
    end
    return String(take!(io))
end

# `parse_frontmatter` already extracts the `# ---`/`title:`/`description:`/`# ---` block;
# strip it here (via Literate's `preprocess` hook) so it doesn't also show up as unrendered
# literal text at the top of the generated page.
function strip_frontmatter(content)
    lines = split(content, '\n')
    lines[1] == "# ---" || return content
    close_idx = findnext(==("# ---"), lines, 2)
    close_idx === nothing && return content
    return join(lines[(close_idx + 1):end], '\n')
end

# Generates `out_root/<category>/<id>.md` and `out_root/index.md`, and returns the
# `pages=`-ready entry for `makedocs`: a nested "Examples gallery" section with one
# subsection per category, listing that category's example pages (bare paths, each
# auto-labeled from the page's own title — no individual `hide(...)`, so the sidebar shows
# every plot title in the active category, not just the current one; Documenter only
# auto-expands the active category by default, so other categories stay collapsed). The
# overview page is labeled "Overview", not left as a bare path, so its nav label doesn't
# collide with the "Examples gallery" section label itself (that collision is what previously
# made Documenter duplicate the label and collapse the sidebar to just the active page).
function build_gallery!(src_root, out_root, categories, prettyurls)
    for (category, _) in categories
        dir = joinpath(src_root, category)
        outdir = joinpath(out_root, category)
        for file in jl_files(dir)
            Literate.markdown(
                joinpath(dir, file), outdir; preprocess=strip_frontmatter, credit=false
            )
        end
    end
    mkpath(out_root)
    write(
        joinpath(out_root, "index.md"),
        gallery_index_markdown(src_root, categories, prettyurls),
    )
    category_pages = [
        category_title => [
            joinpath("gallery", category, "$(splitext(file)[1]).md") for
            file in jl_files(joinpath(src_root, category))
        ] for (category, category_title) in categories
    ]
    return "Examples gallery" =>
        vcat("Overview" => joinpath("gallery", "index.md"), category_pages)
end

# Each example's `@example` block already renders its own plot inline (via the script's
# final `gcf()`); reuse that rendered image as the index page's cover thumbnail instead of
# executing every example a second time just to generate one. Where Documenter puts that
# rendered image depends on `prettyurls`: a sibling `<id>-*.png` next to `<id>.html`, or a
# `*.png` inside the page's own `<id>/` directory (alongside its `index.html`).
function copy_gallery_covers!(src_root, build_root, categories, prettyurls)
    covers_dir = joinpath(build_root, "covers")
    mkpath(covers_dir)
    for example in gallery_sources(src_root, categories)
        dir = if prettyurls
            joinpath(build_root, example.category, example.id)
        else
            joinpath(build_root, example.category)
        end
        matches = filter(readdir(dir)) do f
            endswith(f, ".png") &&
                (prettyurls || startswith(f, "$(example.id)-"))
        end
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
