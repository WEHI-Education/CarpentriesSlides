
#' Convert a slide deck to a PowerPoint presentation
#' 
#' @inheritParams make_reveal
#' @param slides_md Optional output from [make_md] indicating where the slide markdown source is found. 
#'  By default, this function looks in the repo for the slides
#' @param template Path to a powerpoint presentation to copy the style from
#' @export
#' @return The path to the output slides, invisibly.
make_ppt <- function(
    repo,
    slides_md = file.path(repo, "slides.md"),
    output = file.path(repo, "slides.pptx"),
    extra_flags = character(),
    template = NULL,
    verbose = FALSE,
    open = TRUE
){
    pptx_filter <- system.file("extdata", "post_pptx.lua", package="CarpentriesSlides")
    if (file.exists(slides_md) |> isFALSE()){
        cli::cli_abort("{.path {slides_md}} does not exist. Did you forget to run {.code make_md()}?")
    }
    site <- file.path(repo, "site", "built")

    args <- sandpaper:::construct_pandoc_args(slides_md, output, to = "pptx")
    pandoc_args <- list(
        file = slides_md,
        output = output,
        from  = args$from,
        to = "pptx",
        args = c(
            "--resource-path", site,
            "--lua-filter", pptx_filter,
            # If we don't set a slide level, we don't get any "section header" slides
            "--slide-level", "2"
        )
    )

    if (is.character(template)){
        # Add the template if provided
        pandoc_args$args <- c(
            pandoc_args$args,
            "--reference-doc",
            template
        )
    }

    if (isTRUE(verbose)){
        cli::cli_alert_info("Running Pandoc with args:")
        utils::str(pandoc_args, vec.len=100)
    }

    do.call(
        pandoc::pandoc_convert,
        pandoc_args
    )

    if (open) utils::browseURL(output)

    invisible(output)
}
