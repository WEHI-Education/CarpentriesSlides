#' Converts a slide deck to an HTML slideshow
#' @export
#' @param repo Path to the Carpentries Workbench project
make_slides <- function(repo, extra_flags = character()){
    slides_md <- file.path(repo, "slides.md")
    site <- file.path(repo, "site", "built")

    # Path to Varnish's built-in JS and CSS that handles stuff like the accordion expansion
    css_path <- system.file("pkgdown", "assets", "assets", "styles.css", package="varnish")
    js_path <- system.file("pkgdown", "assets", "assets", "scripts.js", package="varnish")
    js_fragment <- tempfile()
    # We need to trigger the "feather" icons manually for some reason
    glue::glue('
        <script src="{js_path}" type="text/javascript"></script>
        <script>feather.replace()</script>
    ') |> writeLines(js_fragment)

    output <- file.path("slides.html") |> normalizePath()
    args <- sandpaper:::construct_pandoc_args(slides_md, output, to = "revealjs")
    to_delete <- which(args$options == "--mathjax")
    options = c(args$options[-to_delete],
                # Look for figures in the lesson directory
                "--resource-path", site,
                # Only split where we indicated, not at headings
                "--slide-level", "0",
                # Include JS assets
                "--embed-resources", "--standalone",
                # Include Carpentries CSS
                "--css", css_path,
                # Include Carpentries JS
                "--include-in-header", js_fragment,
                # Custom CSS from this package
                "--css", system.file("extdata", "carpentries_slides.css", package="CarpentriesSlides"),
                # Use a more minimal Reveal.JS theme so it interferes less
                "--variable", "theme=foo",
                # "--variable", "disableLayout=true",
                "--variable", "center=false",
                # "--metadata", "title=Foo",
                "--metadata", "lang=en",
                extra_flags
            )
    cli::cli_alert_info("Running pandoc with options: {options}")
    pandoc::pandoc_convert(
        file = slides_md,
        output = args$output,
        from  = args$from,
        to = args$to,
        # to = args$to,
        args = options
    )
    cli::cli_alert_success("Slides are available at {.path {output}}")

    # Remove the callout-title from sections.
    # This occurs because of weird behaviour with the revealjs output type in pandoc,
    # which is discussed here: https://github.com/jgm/pandoc/issues/9592.
    # This can't be done in lua because pandoc itself breaks this
    document <- xml2::read_html(output)
    xml2::xml_find_all(document, "//section[contains(@class, 'callout-title')]") |>
    purrr::map(function(node){
        xml2::xml_attr(node, "class") |>
            stringr::str_replace("callout-title", "") |>
            xml2::`xml_attr<-`(node, "class", value=_)
    })
    xml2::write_html(document, output)
}
