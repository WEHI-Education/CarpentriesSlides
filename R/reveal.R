
#' Converts a slide deck to an HTML slideshow
#' @export
#' @param repo Path to the git repository corresponding to a lesson that uses Carpentries Workbench.
#' @param slides_md Optional output from [make_md] indicating where the slide markdown source is found. 
#'  By default, this function looks in the repo for the slides
#' @param output An optional path indicating where the resulting slideshow should be written. 
#'  Character scalar. If not provided, the slides will be saved into the lesson's git repository.
#' @param verbose Logical scalar. TRUE if additional but non-essential logging should be provided.
#' @param open Logical scalar. TRUE if you want the slides to be opened in your browser after they are generated.
#' @param extra_flags Character vector. Extra arguments to pass to `pandoc` to modify the conversion process
#' @param title Character vector. A title to override the default, taken from the lesson configuration
#' @return The path to the output slides, invisibly.
make_reveal <- function(
    repo,
    slides_md = file.path(repo, "slides.md"),
    output = normalizePath(repo) |> file.path("slides.html"),
    extra_flags = character(),
    verbose = FALSE,
    open = TRUE,
    title = NULL
){
    #' Path to the reveal JS postprocessing lua filter
    post_reveal <- system.file("extdata", "post_reveal.lua", package="CarpentriesSlides")

    
    if (file.exists(slides_md) |> isFALSE()){
        cli::cli_abort("{.path {slides_md}} does not exist. Did you forget to run {.code make_md()}?")
    }
    site <- file.path(repo, "site", "built")
    config <- sandpaper::get_config(repo)
    if (is.null(title)){
        title <- config$title
    }
    if (isTRUE(verbose)){
        cli::cli_alert_info("Input markdown is {.path {slides_md}}")
        cli::cli_alert_info('Workshop title is "{title}"')
    }

    # Path to Varnish's built-in JS and CSS that handles stuff like the accordion expansion
    css_path <- system.file("pkgdown", "assets", "assets", "styles.css", package="varnish")
    js_path <- system.file("pkgdown", "assets", "assets", "scripts.js", package="varnish")
    js_fragment <- tempfile()
    # We need to trigger the "feather" icons manually for some reason
    glue::glue('
        <script src="{js_path}" type="text/javascript"></script>
        <script>feather.replace()</script>
    ') |> writeLines(js_fragment)

    args <- sandpaper:::construct_pandoc_args(slides_md, output, to = "revealjs")
    to_delete <- which(args$options == "--mathjax")
    options = c(args$options[-to_delete],
                # Inject our custom lua
                "--lua-filter",
                post_reveal,
                # Look for figures in the lesson directory
                "--resource-path", site,
                # Only split where we indicated, not at headings
                "--slide-level", "0",
                # Include JS assets
                "--embed-resources", "--standalone",
                # Include Carpentries CSS
                "--css", css_path,
                # Include Carpentries JS
                "--include-after-body", js_fragment,
                # Custom CSS from this package
                "--css", system.file("extdata", "carpentries_slides.css", package="CarpentriesSlides"),
                # Use a more minimal Reveal.JS theme so it interferes less
                "--variable", "theme=foo",
                # "--variable", "disableLayout=true",
                # "--variable", "center=false",
                "--metadata", glue::glue("title={title}") |> shQuote(),
                "--metadata", "lang=en",
                extra_flags
            )

    pandoc_args <- list(
        file = slides_md,
        output = args$output,
        from  = args$from,
        to = args$to,
        args = options
    )
    if (isTRUE(verbose)){
        cli::cli_alert_info("Running Pandoc with args:")
        utils::str(pandoc_args, vec.len=100)
    }
    do.call(
        pandoc::pandoc_convert,
        pandoc_args
    )

    # Remove the callout-title from sections.
    # This occurs because of weird behaviour with the revealjs output type in pandoc,
    # which is discussed here: https://github.com/jgm/pandoc/issues/9592.
    # This can't be done in lua because pandoc itself breaks this
    document <- xml2::read_html(output)
    xml2::xml_find_all(document, "//section[contains(@class, 'callout-title')]") |>
    purrr::map(function(node){
        xml2::xml_attr(node, "class") |>
            gsub("callout-title", "", x = _, fixed = TRUE) |>
            xml2::`xml_attr<-`(node, "class", value=_)
    })
    xml2::write_html(document, output)

    cli::cli_alert_success("Slides are available at {.path {output}}")
    if (isTRUE(open)){
        glue::glue("file://{output}") |> utils::browseURL()
    }

    invisible(output)
}
