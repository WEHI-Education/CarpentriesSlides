make_ppt <- function(repo, extra_flags = character(), template = NULL, verbose = FALSE, open = TRUE){
    slides_md <- file.path(repo, "slides.md")
    slides_pptx <- file.path(repo, "slides.pptx")
    site <- file.path(repo, "site", "built")

    args <- sandpaper:::construct_pandoc_args(slides_md, slides_pptx, to = "pptx")
    pandoc_args <- list(
        file = slides_md,
        output = slides_pptx,
        from  = args$from,
        args = c(
            "--resource-path", site,
        )
    )

    if (!is.null(template)){
        # Add the template if provided
        pandoc_args$args <- c(
            pandoc_args$args,
            "--reference-doc",
            template
        )
    }

    # TODO: add lua filter to strip out divs
    # TODO run conversion
}
