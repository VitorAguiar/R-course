#### installing git:

-   Mac OS (homebrew)
    -   brew install git
-   Ubuntu (apt-get)
    -   sudo apt-get install git-core
-   Windows
    -   [Windows build on the git website](https://git-scm.com)

#### settings

go to your shell and execute the following commands:

    git config --global user.name "Your Name"
    git config --global user.email "your@email.com"    

#### authentication with git remotes

consult the GitHub article on [adding SSH
keys](https://help.github.com/articles/generating-ssh-keys/#platform-all)

or follow these steps:

-   go to Rstudio global options (Tools \> Global Options...)
-   click on the Git/SVN pane
-   click on the button "Create RSA Key"
-   copy the key
-   go to your GitHub settings \> SSH keys
-   click on the button "Add SSH key"
-   paste the key and save

#### in Rstudio:

-   install the devtools package

<!-- -->

    install.packages("devtools")

-   go to file \> New Project \> New Directory \> R package
-   choose a name for you package
-   check the box "Create a git repository"

R package names must:

-   contain only letters, number or periods
-   start with a letter and not end with a period

Recommendations:

-   the use of periods are not recommended
-   avoid using both lower and upper case letters
-   find a good name!

*"There are only two hard things in Computer Science: cache invalidation
and naming things."*

> --<cite>Phil Karlton</cite>

#### create a repository on GitHub

-   copy the URL (something like `git@github.com:user/repo.git`)

#### go to your shell

    cd path_to_package_dir
    git add remote origin git@github.com:user/repo.git

#### Rstudio

-   go to the pane which lists your files
-   click on the "Git" tab
-   check the box under "Staged"
-   click on the commit button
-   write a message describing the commit
-   click on "commit"
-   back in the Rstudio pane, click on the "push" button

-   go to the GitHub's repository and refresh the page

#### version control

-   everytime you create or modify a file, you need to *stage* it
-   *commits* represent snapshots of your project
-   *push* sends commits to the remote repository
-   *pull* retrives commits from the remote repository
