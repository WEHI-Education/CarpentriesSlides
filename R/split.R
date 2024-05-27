#' Generates a markdown slide deck from a Carpentries workbench project
#' @export
#' @param repo A length-1 character vector pointing to the root of a Carpentries workbench project
#' @param verbose Logical scalar. TRUE if additional but non-essential logging should be provided.
make_md <- function(repo, verbose = FALSE){
    # Ensure the markdown has been knitted
    sandpaper:::build_markdown(repo)

    episodes <- sandpaper::get_episodes(repo) |>
        gsub(".Rmd", ".md", x = _, fixed = TRUE) |>
        file.path(repo, "site", "built", suffix = _)

    if (isTRUE(verbose)){
        cli::cli_alert_info("Converting: {all_inputs}")
    }

    output <- file.path(repo, "slides.md")
    episodes |>
        purrr::map(ep_to_markdown) |>
        do.call(c, args = _) |>
        writeLines(output)

    cli::cli_alert_success("Slides can be found in {.path {output}}")
    cli::cli_alert_success("Once you have made any necessary changes, you can build the slides using {.code make_slides(\"{repo}\")}")
}

#' Converts a single slide to markdown
#' @param slide A character scalar of an episode markdown file to include in the slide show.
#'  Ordinarily these are in `/site/built` within a Carpentries repo
#' @return A length-1 character vector of the pandoc markdown content.
#' @noRd
ep_to_markdown <- function(episode){
    lua_filter <- system.file("extdata", "split_slides.lua", package="CarpentriesSlides")
    format <- sandpaper:::construct_pandoc_args(episode, "foo.md", to = "markdown")$from
    tryCatch({
        result <- pandoc::pandoc_convert(
            file = episode,
            # Convert to the same format
            from = format,
            to = format,
            args = c(
                # Split the slides appropriately
                "--lua-filter", lua_filter
            )
        )
    }, error = function(e){
        cli::cli_abort("Failed to convert episode {episode} with error:\n{e}")
    })

    # Add a newline in case it's missing
    c(result, "\n")
}
