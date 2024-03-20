# How to extract slides from a Carpentries workshop

We will use the `git-novice` workshop as an example

1. Install this package using `remotes::install_github("multimeric/CarpentriesSlides")`
2. Clone the repo, for example `git clone git@github.com:swcarpentry/git-novice.git`
3. In R, run `CarpentriesSlides::make_slides("/path/to/git-novice")`
4. Inside the `git-novice` repository, the slides will be located at `/site/built/*_slides.html`, one for each episode
