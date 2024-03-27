#' Generates a markdown slide deck from a Carpentries workbench project
#' @export
#' @param repo A length-1 character vector pointing to the root of a Carpentries workbench project
slides_to_markdown <- function(repo){
    # Ensure the markdown has been knitted
    sandpaper:::build_markdown(repo)

    built_dir <- file.path(repo, "site", "built")
    all_inputs <- built_dir |> 
        list.files(full.names = TRUE, pattern="^\\d\\d.+\\.md$")
    cli::cli_alert_info("Converting: {all_inputs}")

    output <- file.path(repo, "slides.md")
    all_inputs |>
        purrr::map(slide_to_markdown) |>
        do.call(c, args = _) |>
        writeLines(output)
    cli::cli_alert_success("Slides can be found in {.path {output}}")
}

#' @param slides A character vector of paths to slides to include in the slide show.
#' @return A length-1 character vector of the pandoc markdown
#'  Ordinarily these are in `/site/built` within a Carpentries repo
slide_to_markdown <- function(slides){
    # output <- tools::file_path_sans_ext(nslide) |> paste0("_slides.html")
    lua_filter <- system.file("extdata", "split_slides.lua", package="CarpentriesSlides")
    format <- sandpaper:::construct_pandoc_args(slides, "foo.md", to = "markdown")$from
    result <- pandoc::pandoc_convert(
        file = slides,
        # Convert to the same format
        from = format,
        to = format,
        args = c(
            # Split the slides appropriately
            "--lua-filter", lua_filter
        )
    )

    # Add a newline in case it's missing
    c(result, "\n")
}
