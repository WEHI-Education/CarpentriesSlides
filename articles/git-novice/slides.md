# Agenda
1. Setting Up Git
2. Creating a Repository
3. Tracking Changes
4. Exploring History
5. Ignoring Things
6. Remotes in GitHub
7. Collaborating
8. Conflicts
9. Open Science
10. Licensing
11. Citation
12. Hosting
13. Supplemental: Using Git from RStudio

---

# Automated Version Control

::: overview
## Objectives

-   Understand the benefits of an automated version control system.
-   Understand the basics of how automated version control systems work.
:::

::: overview
## Questions

-   What is version control and why should I use it?
:::

------------------------------------------------------------------------

![Comic: a PhD student sends \"FINAL.doc\" to their supervisor, but
after several increasingly intense and frustrating rounds of comments
and revisions they end up with a file named
\"FINAL_rev.22.comments49.corrections.10.#@\$%WHYDIDCOMETOGRADSCHOOL????.doc\"](fig/phd101212s.png)

------------------------------------------------------------------------

![](fig/play-changes.svg){alt="A diagram demonstrating how a single document grows as the result of sequential changes"}

------------------------------------------------------------------------

![](fig/versions.svg){alt="A diagram with one source document that has been modified in two different ways to produce two different versions of the document"}

------------------------------------------------------------------------

![](fig/merge.svg){alt="A diagram that shows the merging of two different document versions into one document that contains all of the changes from both versions"}

------------------------------------------------------------------------

::: challenge
## Paper Writing

-   Imagine you drafted an excellent paragraph for a paper you are
    writing, but later ruin it. How would you retrieve the *excellent*
    version of your conclusion? Is it even possible?

-   Imagine you have 5 co-authors. How would you manage the changes and
    comments they make to your paper? If you use LibreOffice Writer or
    Microsoft Word, what happens if you accept changes made using the
    `Track Changes` option? Do you have a history of those changes?
:::

------------------------------------------------------------------------


# Setting Up Git

::: overview
## Objectives

-   Configure `git` the first time it is used on a computer.
-   Understand the meaning of the `--global` configuration flag.
:::

::: overview
## Questions

-   How do I get set up to use Git?
:::

------------------------------------------------------------------------


# Creating a Repository

::: overview
## Objectives

-   Create a local Git repository.
-   Describe the purpose of the `.git` directory.
:::

::: overview
## Questions

-   Where does Git store information?
:::

------------------------------------------------------------------------

![](fig/motivatingexample.png){alt="The main elements of the story: Dracula, Wolfman, the Mummy, Mars, Pluto and The Moon"}

------------------------------------------------------------------------

::: challenge
## Places to Create Git Repositories

Along with tracking information about planets (the project we have
already created), Dracula would also like to track information about
moons. Despite Wolfman's concerns, Dracula creates a `moons` project
inside his `planets` project with the following sequence of commands:

``` bash
$ cd ~/Desktop   # return to Desktop directory
$ cd planets     # go into planets directory, which is already a Git repository
$ ls -a          # ensure the .git subdirectory is still present in the planets directory
$ mkdir moons    # make a subdirectory planets/moons
$ cd moons       # go into moons subdirectory
$ git init       # make the moons subdirectory a Git repository
$ ls -a          # ensure the .git subdirectory is present indicating we have created a new Git repository
```

Is the `git init` command, run inside the `moons` subdirectory, required
for tracking files stored in the `moons` subdirectory?

## Correcting `git init` Mistakes

Wolfman explains to Dracula how a nested repository is redundant and may
cause confusion down the road. Dracula would like to go back to a single
git repository. How can Dracula undo his last `git init` in the `moons`
subdirectory?
:::

------------------------------------------------------------------------


# Tracking Changes

::: overview
## Objectives

-   Go through the modify-add-commit cycle for one or more files.
-   Explain where information is stored at each stage of that cycle.
-   Distinguish between descriptive and non-descriptive commit messages.
:::

::: overview
## Questions

-   How do I record changes in Git?
-   How do I check the status of my version control repository?
-   How do I record notes about what changes I made and why?
:::

------------------------------------------------------------------------

![](fig/git-staging-area.svg){alt="A diagram showing how \"git add\" registers changes in the staging area, while \"git commit\" moves changes from the staging area to the repository"}

------------------------------------------------------------------------

![](fig/git-committing.svg){alt="A diagram showing two documents being separately staged using git add, before being combined into one commit using git commit"}

------------------------------------------------------------------------

::: challenge
## Choosing a Commit Message

Which of the following commit messages would be most appropriate for the
last commit made to `mars.txt`?

1.  "Changes"
2.  "Added line 'But the Mummy will appreciate the lack of humidity' to
    mars.txt"
3.  "Discuss effects of Mars' climate on the Mummy"
:::

------------------------------------------------------------------------

::: challenge
## Committing Changes to Git

Which command(s) below would save the changes of `myfile.txt` to my
local Git repository?

1.  ``` bash
       $ git commit -m "my recent changes"
    ```

2.  ``` bash
       $ git init myfile.txt
       $ git commit -m "my recent changes"
    ```

3.  ``` bash
       $ git add myfile.txt
       $ git commit -m "my recent changes"
    ```

4.  ``` bash
       $ git commit -m myfile.txt "my recent changes"
    ```
:::

------------------------------------------------------------------------

::: challenge
## Committing Multiple Files

The staging area can hold changes from any number of files that you want
to commit as a single snapshot.

1.  Add some text to `mars.txt` noting your decision to consider Venus
    as a base
2.  Create a new file `venus.txt` with your initial thoughts about Venus
    as a base for you and your friends
3.  Add changes from both files to the staging area, and commit those
    changes.
:::

------------------------------------------------------------------------

::: challenge
## `bio` Repository

-   Create a new Git repository on your computer called `bio`.
-   Write a three-line biography for yourself in a file called `me.txt`,
    commit your changes
-   Modify one line, add a fourth line
-   Display the differences between its updated state and its original
    state.
:::

------------------------------------------------------------------------


# Exploring History

::: overview
## Objectives

-   Explain what the HEAD of a repository is and how to use it.
-   Identify and use Git commit numbers.
-   Compare various versions of tracked files.
-   Restore old versions of files.
:::

::: overview
## Questions

-   How can I identify old versions of files?
-   How do I review my changes?
-   How can I recover old versions of files?
:::

------------------------------------------------------------------------

![](fig/git-checkout.svg){alt="A diagram showing how git checkout HEAD~1 can be used to restore the previous version of two files"}

------------------------------------------------------------------------

![A diagram showing the entire git workflow: local changes are staged
using git add, applied to the local repository using git commit, and can
be restored from the repository using git checkout](fig/git_staging.svg)

------------------------------------------------------------------------

::: challenge
## Recovering Older Versions of a File

Jennifer has made changes to the Python script that she has been working
on for weeks, and the modifications she made this morning "broke" the
script and it no longer runs. She has spent \~ 1hr trying to fix it,
with no luck...

Luckily, she has been keeping track of her project's versions using Git!
Which commands below will let her recover the last committed version of
her Python script called `data_cruncher.py`?

1.  `$ git checkout HEAD`

2.  `$ git checkout HEAD data_cruncher.py`

3.  `$ git checkout HEAD~1 data_cruncher.py`

4.  `$ git checkout <unique ID of last commit> data_cruncher.py`

5.  Both 2 and 4
:::

------------------------------------------------------------------------

::: challenge
## Reverting a Commit

Jennifer is collaborating with colleagues on her Python script. She
realizes her last commit to the project's repository contained an error,
and wants to undo it. Jennifer wants to undo correctly so everyone in
the project's repository gets the correct change. The command
`git revert [erroneous commit ID]` will create a new commit that
reverses the erroneous commit.

The command `git revert` is different from `git checkout [commit ID]`
because `git checkout` returns the files not yet committed within the
local repository to a previous state, whereas `git revert` reverses
changes committed to the local and project repositories.

Below are the right steps and explanations for Jennifer to use
`git revert`, what is the missing command?

1.  `________ # Look at the git history of the project to find the commit ID`

2.  Copy the ID (the first few characters of the ID, e.g. 0b1d055).

3.  `git revert [commit ID]`

4.  Type in the new commit message.

5.  Save and close
:::

------------------------------------------------------------------------

::: challenge
## Understanding Workflow and History

What is the output of the last command in

``` bash
$ cd planets
$ echo "Venus is beautiful and full of love" > venus.txt
$ git add venus.txt
$ echo "Venus is too hot to be suitable as a base" >> venus.txt
$ git commit -m "Comment on Venus as an unsuitable base"
$ git checkout HEAD venus.txt
$ cat venus.txt #this will print the contents of venus.txt to the screen
```

1.  ``` output
      Venus is too hot to be suitable as a base
    ```

2.  ``` output
      Venus is beautiful and full of love
    ```

3.  ``` output
      Venus is beautiful and full of love
      Venus is too hot to be suitable as a base
    ```

4.  ``` output
      Error because you have changed venus.txt without committing the changes
    ```
:::

------------------------------------------------------------------------

::: challenge
## Checking Understanding of `git diff`

Consider this command: `git diff HEAD~9 mars.txt`. What do you predict
this command will do if you execute it? What happens when you do execute
it? Why?

Try another command, `git diff [ID] mars.txt`, where \[ID\] is replaced
with the unique identifier for your most recent commit. What do you
think will happen, and what does happen?
:::

------------------------------------------------------------------------

::: challenge
## Getting Rid of Staged Changes

`git checkout` can be used to restore a previous commit when unstaged
changes have been made, but will it also work for changes that have been
staged but not committed? Make a change to `mars.txt`, add that change
using `git add`, then use `git checkout` to see if you can remove your
change.
:::

------------------------------------------------------------------------

::: challenge
## Explore and Summarize Histories

Exploring history is an important part of Git, and often it is a
challenge to find the right commit ID, especially if the commit is from
several months ago.

Imagine the `planets` project has more than 50 files. You would like to
find a commit that modifies some specific text in `mars.txt`. When you
type `git log`, a very long list appeared. How can you narrow down the
search?

Recall that the `git diff` command allows us to explore one specific
file, e.g., `git diff mars.txt`. We can apply a similar idea here.

``` bash
$ git log mars.txt
```

Unfortunately some of these commit messages are very ambiguous, e.g.,
`update files`. How can you search through these files?

Both `git diff` and `git log` are very useful and they summarize a
different part of the history for you. Is it possible to combine both?
Let's try the following:

``` bash
$ git log --patch mars.txt
```

You should get a long list of output, and you should be able to see both
commit messages and the difference between each commit.

Question: What does the following command do?

``` bash
$ git log --patch HEAD~9 *.txt
```
:::

------------------------------------------------------------------------


# Ignoring Things

::: overview
## Objectives

-   Configure Git to ignore specific files.
-   Explain why ignoring files can be useful.
:::

::: overview
## Questions

-   How can I tell Git to ignore files I don't want to track?
:::

------------------------------------------------------------------------

::: challenge
## Ignoring Nested Files

Given a directory structure that looks like:

``` bash
results/data
results/plots
```

How would you ignore only `results/plots` and not `results/data`?
:::

------------------------------------------------------------------------

::: challenge
## Including Specific Files

How would you ignore all `.csv` files in your root directory except for
`final.csv`? Hint: Find out what `!` (the exclamation point operator)
does
:::

------------------------------------------------------------------------

::: challenge
## Ignoring Nested Files: Variation

Given a directory structure that looks similar to the earlier Nested
Files exercise, but with a slightly different directory structure:

``` bash
results/data
results/images
results/plots
results/analysis
```

How would you ignore all of the contents in the results folder, but not
`results/data`?

Hint: think a bit about how you created an exception with the `!`
operator before.
:::

------------------------------------------------------------------------

::: challenge
## Ignoring all data Files in a Directory

Assuming you have an empty .gitignore file, and given a directory
structure that looks like:

``` bash
results/data/position/gps/a.csv
results/data/position/gps/b.csv
results/data/position/gps/c.csv
results/data/position/gps/info.txt
results/plots
```

What's the shortest `.gitignore` rule you could write to ignore all
`.csv` files in `result/data/position/gps`? Do not ignore the
`info.txt`.
:::

------------------------------------------------------------------------

::: challenge
## Ignoring all data Files in the repository

Let us assume you have many `.csv` files in different subdirectories of
your repository. For example, you might have:

``` bash
results/a.csv
data/experiment_1/b.csv
data/experiment_2/c.csv
data/experiment_2/variation_1/d.csv
```

How do you ignore all the `.csv` files, without explicitly listing the
names of the corresponding folders?
:::

------------------------------------------------------------------------

::: challenge
## The Order of Rules

Given a `.gitignore` file with the following contents:

``` bash
*.csv
!*.csv
```

What will be the result?
:::

------------------------------------------------------------------------

::: challenge
## Log Files

You wrote a script that creates many intermediate log-files of the form
`log_01`, `log_02`, `log_03`, etc. You want to keep them but you do not
want to track them through `git`.

1.  Write **one** `.gitignore` entry that excludes files of the form
    `log_01`, `log_02`, etc.

2.  Test your "ignore pattern" by creating some dummy files of the form
    `log_01`, etc.

3.  You find that the file `log_01` is very important after all, add it
    to the tracked files without changing the `.gitignore` again.

4.  Discuss with your neighbor what other types of files could reside in
    your directory that you do not want to track and thus would exclude
    via `.gitignore`.
:::

------------------------------------------------------------------------


# Remotes in GitHub

::: overview
## Objectives

-   Explain what remote repositories are and why they are useful.
-   Push to or pull from a remote repository.
:::

::: overview
## Questions

-   How do I share my changes with others on the web?
:::

------------------------------------------------------------------------

![](fig/github-create-repo-01.png){alt="The first step in creating a repository on GitHub: clicking the \"create new\" button"}

------------------------------------------------------------------------

![](fig/github-create-repo-02.png){alt="The second step in creating a repository on GitHub: filling out the new repository form to provide the repository name, and specify that neither a readme nor a license should be created"}

------------------------------------------------------------------------

![](fig/github-create-repo-03.png){alt="The summary page displayed by GitHub after a new repository has been created. It contains instructions for configuring the new GitHub repository as a git remote"}

------------------------------------------------------------------------

![](fig/git-staging-area.svg){alt="A diagram showing how \"git add\" registers changes in the staging area, while \"git commit\" moves changes from the staging area to the repository"}

------------------------------------------------------------------------

![](fig/git-freshly-made-github-repo.svg)

------------------------------------------------------------------------

![](fig/github-find-repo-string.png)

------------------------------------------------------------------------

![](fig/github-change-repo-string.png){alt="A screenshot showing that clicking on \"SSH\" will make GitHub provide the SSH URL for a repository instead of the HTTPS URL"}

------------------------------------------------------------------------

![](fig/github-repo-after-first-push.svg){alt="A diagram showing how \"git push origin\" will push changes from the local repository to the remote, making the remote repository an exact copy of the local repository."}

------------------------------------------------------------------------

::: challenge
## GitHub GUI

Browse to your `planets` repository on GitHub. Underneath the Code
button, find and click on the text that says "XX commits" (where "XX" is
some number). Hover over, and click on, the three buttons to the right
of each commit. What information can you gather/explore from these
buttons? How would you get that same information in the shell?
:::

------------------------------------------------------------------------

::: challenge
## GitHub Timestamp

Create a remote repository on GitHub. Push the contents of your local
repository to the remote. Make changes to your local repository and push
these changes. Go to the repo you just created on GitHub and check the
[timestamps](../learners/reference.md#timestamp) of the files. How does
GitHub record times, and why?
:::

------------------------------------------------------------------------

::: challenge
## Push vs. Commit

In this episode, we introduced the "git push" command. How is "git push"
different from "git commit"?
:::

------------------------------------------------------------------------

::: challenge
## GitHub License and README files

In this episode we learned about creating a remote repository on GitHub,
but when you initialized your GitHub repo, you didn't add a README.md or
a license file. If you had, what do you think would have happened when
you tried to link your local and remote repositories?
:::

------------------------------------------------------------------------


# Collaborating

::: overview
## Objectives

-   Clone a remote repository.
-   Collaborate by pushing to a common repository.
-   Describe the basic collaborative workflow.
:::

::: overview
## Questions

-   How can I use version control to collaborate with other people?
:::

------------------------------------------------------------------------

![](fig/github-add-collaborators.png){alt="A screenshot of the GitHub Collaborators settings page, which is accessed by clicking \"Settings\" then \"Collaborators\""}

------------------------------------------------------------------------

![](fig/github-collaboration.svg){alt="A diagram showing that \"git clone\" can create a copy of a remote GitHub repository, allowing a second person to create their own local repository that they can make changes to."}

------------------------------------------------------------------------

::: challenge
## Switch Roles and Repeat

Switch roles and repeat the whole process.
:::

------------------------------------------------------------------------

::: challenge
## Review Changes

The Owner pushed commits to the repository without giving any
information to the Collaborator. How can the Collaborator find out what
has changed with command line? And on GitHub?
:::

------------------------------------------------------------------------

::: challenge
## Comment Changes in GitHub

The Collaborator has some questions about one line change made by the
Owner and has some suggestions to propose.

With GitHub, it is possible to comment on the diff of a commit. Over the
line of code to comment, a blue comment icon appears to open a comment
window.

The Collaborator posts her comments and suggestions using the GitHub
interface.
:::

------------------------------------------------------------------------

::: challenge
## Version History, Backup, and Version Control

Some backup software can keep a history of the versions of your files.
They also allows you to recover specific versions. How is this
functionality different from version control? What are some of the
benefits of using version control, Git and GitHub?
:::

------------------------------------------------------------------------


# Conflicts

::: overview
## Objectives

-   Explain what conflicts are and when they can occur.
-   Resolve conflicts resulting from a merge.
:::

::: overview
## Questions

-   What do I do when my changes conflict with someone else's?
:::

------------------------------------------------------------------------

![](fig/conflict.svg){alt="A diagram showing a conflict that might occur when two sets of independent changes are merged"}

------------------------------------------------------------------------

::: challenge
## Solving Conflicts that You Create

Clone the repository created by your instructor. Add a new file to it,
and modify an existing file (your instructor will tell you which one).
When asked by your instructor, pull her changes from the repository to
create a conflict, then resolve it.
:::

------------------------------------------------------------------------

::: challenge
## Conflicts on Non-textual files

What does Git do when there is a conflict in an image or some other
non-textual file that is stored in version control?
:::

------------------------------------------------------------------------

::: challenge
## A Typical Work Session

You sit down at your computer to work on a shared project that is
tracked in a remote Git repository. During your work session, you take
the following actions, but not in this order:

-   *Make changes* by appending the number `100` to a text file
    `numbers.txt`
-   *Update remote* repository to match the local repository
-   *Celebrate* your success with some fancy beverage(s)
-   *Update local* repository to match the remote repository
-   *Stage changes* to be committed
-   *Commit changes* to the local repository

In what order should you perform these actions to minimize the chances
of conflicts? Put the commands above in order in the *action* column of
the table below. When you have the order right, see if you can write the
corresponding commands in the *command* column. A few steps are
populated to get you started.

  ---------------------------------------------------------------------------
  order   action . . . . . . . . . command . . . . . . . . . .
          .                        
  ------- ------------------------ ------------------------------------------
  1                                

  2                                `echo 100 >> numbers.txt`

  3                                

  4                                

  5                                

  6       Celebrate!               
  ---------------------------------------------------------------------------
:::

------------------------------------------------------------------------


# Open Science

::: overview
## Objectives

-   Explain how a version control system can be leveraged as an
    electronic lab notebook for computational work.
:::

::: overview
## Questions

-   How can version control help me make my work more open?
:::

------------------------------------------------------------------------

::: challenge
## How Reproducible Is My Work?

Ask one of your labmates to reproduce a result you recently obtained
using only what they can find in your papers or on the web. Try to do
the same for one of their results, then try to do it for a result from a
lab you work with.
:::

------------------------------------------------------------------------

::: challenge
## How to Find an Appropriate Data Repository?

Surf the internet for a couple of minutes and check out the data
repositories mentioned above: [Figshare](https://figshare.com/),
[Zenodo](https://zenodo.org), [Dryad](https://datadryad.org/). Depending
on your field of research, you might find community-recognized
repositories that are well-known in your field. You might also find
useful [these data repositories recommended by
Nature](https://www.nature.com/sdata/data-policies/repositories).
Discuss with your neighbor which data repository you might want to
approach for your current project and explain why.
:::

------------------------------------------------------------------------

::: challenge
## How to Track Large Data or Image Files using Git?

Large data or image files such as `.md5` or `.psd` file types can be
tracked within a github repository using the [Git Large File
Storage](https://git-lfs.github.com) open source extension tool. This
tool automatically uploads large file contents to a remote server and
replaces the file with a text pointer within the github repository.

Try downloading and installing the Git Large File Storage extension
tool, then add tracking of a large file to your github repository. Ask a
colleague to clone your repository and describe what they see when they
access that large file.
:::

------------------------------------------------------------------------


# Licensing

::: overview
## Objectives

-   Explain why adding licensing information to a repository is
    important.
-   Choose a proper license.
-   Explain differences in licensing and social expectations.
:::

::: overview
## Questions

-   What licensing information should I include with my work?
:::

------------------------------------------------------------------------

::: challenge
## Can I Use Open License?

Find out whether you are allowed to apply an open license to your
software. Can you do this unilaterally, or do you need permission from
someone in your institution? If so, who?
:::

------------------------------------------------------------------------

::: challenge
## What licenses have I already accepted?

Many of the software tools we use on a daily basis (including in this
workshop) are released as open-source software. Pick a project on GitHub
from the list below, or one of your own choosing. Find its license
(usually in a file called `LICENSE` or `COPYING`) and talk about how it
restricts your use of the software. Is it one of the licenses discussed
in this session? How is it different?

-   [Git](https://github.com/git/git), the source-code management tool
-   [CPython](https://github.com/python/cpython), the standard
    implementation of the Python language
-   [Jupyter](https://github.com/jupyter), the project behind the
    web-based Python notebooks we'll be using
-   [EtherPad](https://github.com/ether/etherpad-lite), a real-time
    collaborative editor
:::

------------------------------------------------------------------------


# Citation

::: overview
## Objectives

-   Make your work easy to cite
:::

::: overview
## Questions

-   How can I make my work easier to cite?
:::

------------------------------------------------------------------------


# Hosting

::: overview
## Objectives

-   Explain different options for hosting scientific work.
:::

::: overview
## Questions

-   Where should I host my version control repositories?
:::

------------------------------------------------------------------------

::: challenge
## Can My Work Be Public?

Find out whether you are allowed to host your work openly in a public
repository. Can you do this unilaterally, or do you need permission from
someone in your institution? If so, who?
:::

------------------------------------------------------------------------

::: challenge
## Where Can I Share My Work?

Does your institution have a repository or repositories that you can use
to share your papers, data and software? How do institutional
repositories differ from services like [arXiV](https://arxiv.org/),
[figshare](https://figshare.com/), [GitHub](https://github.com/) or
[GitLab](https://about.gitlab.com/)?
:::

------------------------------------------------------------------------


# Supplemental: Using Git from RStudio

::: overview
## Objectives

-   Understand how to use Git from RStudio.
:::

::: overview
## Questions

-   How can I use Git with RStudio?
:::

------------------------------------------------------------------------

![](fig/RStudio_screenshot_newproject.png){alt="RStudio screenshot showing the file menu dropdown with \"New Project...\" selected"}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_existingdirectory.png){alt="RStudio screenshot showing New Project dialog window with \"Create project from existing directory\" selected"}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_navigateexisting.png){alt="RStudio window showing the \"Create Project From Existing Directory\" dialog. In the dialog, the project working directory has been set to \"~/Desktop/planets\""}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_afterclone.png){alt="RStudio window after new project is created with large arrow pointing to vertical Git menu bar."}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_editfiles.png){alt="RStudio window demonstrating the use of the editor panel to modify the \"pluto.txt\" file"}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_commit.png){alt="RStudio screenshot showing the Git menu dropdown with the \"Commit...\" option selected"}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_review.png){alt="RStudio screenshow showing the \"Review Changes\" dialog. The top left panel shows the list of files that can be included or excluded from the commit. The top right panel is for writing a commit message. The bottom panel shows information about the currently selected file in the top left panel."}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_history.png){alt="RStudio screenshot showing the git menu dropdown with the \"History\" option selected"}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_viewhistory.png){alt="RStudio screenshot showing the \"Review Changes\" dialog after pressing the \"History\" button. The top panel lists the commits in the repository, similar to git log. The bottom panel shows the changes included in the commit that has been selected in the top panel."}

------------------------------------------------------------------------

![](fig/RStudio_screenshot_gitignore.png){alt="RStudio screenshot showing .gitignore open in the editor pane with the files .Rproj.user, .Rhistory, .RData, and *.Rproj added to the end"}

------------------------------------------------------------------------

::: challenge
## Challenge

1.  Create a new directory within your project called `graphs`.
2.  Modify the `.gitignore` so that the `graphs` directory is not
    version controlled.
:::

------------------------------------------------------------------------


