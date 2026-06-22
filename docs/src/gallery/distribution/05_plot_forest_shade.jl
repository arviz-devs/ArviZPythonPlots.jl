# # Forest plot with shading
#
# Forest plot marginal summaries with row shading to enhance reading.

using ArviZPythonPlots, ArviZExampleData

use_style("arviz-variat")

data = load_example_data("rugby")
pc = plot_forest(data; var_names=["home", "atts", "defs"], shade_label="team")
gcf()

# See [`plot_forest`](@ref).
