# Carpentries Slides

This package generates minimal slideshows from a Carpentries Workbench lesson, in order to facilitate teaching workshops.

## What is included?

* A title slide for each episode
* A slide for each figure in the lesson
* A slide for each challenge block
* A slide for each discussion point

## Installation

From R:
```R
options(repos = c(
  carpentries = "https://carpentries.r-universe.dev/", 
  CRAN = "https://cran.rstudio.com/"
))

remotes::install_github("WEHI-ResearchComputing/CarpentriesSlides")
```

## Documentation

**Please visit <https://wehi-researchcomputing.github.io/CarpentriesSlides> for comprehensive documentation!**

## Usage

Start your R interpreter:
```R
# This is the path to the Workbench lesson repository.
# In this example, we're using git novice
workshop <- "/path/to/git-novice"

# Convert the material to a markdown slide deck
CarpentriesSlides::make_md(workshop)

# At this point, the package will print out the path to a markdown file within the repo
# that you can edit if you want to add or remove material

# Convert the markdown to HTML
CarpentriesSlides::make_slides(workshop)
```

At this point, the package will print out something like:
```
✔ Slides are available at /path/to/git-novice/slides.html
```

You can then open this `slides.html` file in your browser and present them!

## FAQ
### But I thought Carpentries didn't allow slides?

The main bulk of Carpentries workshops should still be live coding.
However, it is a common and accepted practice that certain parts of a workshop can be presented using slides.

For more discussion on this topic, see:

* https://carpentries.slack.com/archives/C03DEQ5T2DA/p1699833900987289
* https://github.com/carpentries/workbench/issues/78
* https://github.com/carpentries/styles/issues/113

### Why not add this feature to the Carpentries workbench directly?

The Workbench maintenance team didn't have time to address my proposed feature: https://github.com/carpentries/workbench/issues/78#issuecomment-1947548345.
However, I'm very open to merging this into the Workbench when it becomes possible

### Why not just use the Extract All Images button?

It's true that this button helps present figures, but I find that opening an image viewer in a workshop doesn't feel as polished as a slideshow.
In addition, there is other content that is useful to be included in the slides, as noted above
