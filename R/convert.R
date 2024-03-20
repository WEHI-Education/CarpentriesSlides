#' @param
make_slides <- function(repo, output){
    sandpaper:::build_markdown(repo)

    built_md <- file.path(repo, "site", "built")
    all_inputs <- built_md |> 
        list.files(full.names = TRUE, pattern=".md$")
        # c("READ")

    css_path <- system.file("pkgdown", "assets", "assets", "styles.css", package="varnish")
    js_path <- system.file("pkgdown", "assets", "assets", "scripts.js", package="varnish")
    js_fragment <- tempfile()
    glue::glue('
        <!-- Varnish JS -->
        <script src="{js_path}"></script>
    ') |> writeLines(js_fragment)

    all_inputs |>
        purrr::walk(function(input){
            output <- tools::file_path_sans_ext(input) |> paste0("_slides.html")
            lua_filter <- system.file("extdata", "split_slides.lua", package="CarpentriesSlides")
            args <- sandpaper:::construct_pandoc_args(
                input,
                output,
                to = "revealjs",
                # Split the slides appropriately
                "--lua-filter", lua_filter,
                # Only split where we indicated, not at headings
                "--slide-level", "0",
                # Include JS assets
                "--embed-resources", "--standalone",
                # Include Carpentries CSS
                "--css", css_path,
                # Include Carpentries JS
                "--include-in-header", js_fragment,
                # Use a more minimal Reveal.JS theme so it interferes less
                "--variable", "theme=simple",
                # "--variable", "disableLayout=true",
                "--variable", "center=false"
            )
            pandoc::pandoc_convert(
                file = args$input,
                output = args$output,
                from  = args$from,
                to = args$to,
                args = args$options
            )
        })


}
