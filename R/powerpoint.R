
#' Convert a slide deck to a PowerPoint presentation
#' 
#' @inheritParams make_reveal
#' @export
make_ppt <- function(repo, extra_flags = character(), template = NULL, verbose = FALSE, open = TRUE){
    pptx_filter <- system.file("extdata", "post_pptx.lua", package="CarpentriesSlides")
    slides_md <- file.path(repo, "slides.md")
    if (file.exists(slides_md) |> isFALSE()){
        cli::cli_abort("{.path {slides_md}} does not exist. Did you forget to run {.code make_md()}?")
    }
    slides_pptx <- file.path(repo, "slides.pptx")
    site <- file.path(repo, "site", "built")

    args <- sandpaper:::construct_pandoc_args(slides_md, slides_pptx, to = "pptx")
    pandoc_args <- list(
        file = slides_md,
        output = slides_pptx,
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
        str(pandoc_args, vec.len=100)
    }

    do.call(
        pandoc::pandoc_convert,
        pandoc_args
    )
}
