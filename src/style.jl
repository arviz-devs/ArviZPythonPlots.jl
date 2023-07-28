"""
    use_style(style::String)
    use_style(style::Vector{String})

Use matplotlib style settings from a style specification `style`.

The style name of "default" is reserved for reverting back to the default style settings.

ArviZ-specific styles are
`["arviz-whitegrid", "arviz-darkgrid", "arviz-colors", "arviz-white"]`.
To see all available style specifications, use [`styles()`](@ref).

If a `Vector` of styles is provided, they are applied from first to last.
"""
use_style(style) = plt.style.use(style)

"""
    styles() -> Vector{String}

Get all available matplotlib styles for use with [`use_style`](@ref)
"""
styles() = plt.style.available
