#### installing git:

-   Mac OS (homebrew)
    -   brew install git
-   Ubuntu (apt-get)
    -   apt-get install git
-   Windows
    -   [Windows build on the git website](https://git-scm.com)

#### settings

    git config --global user.name "Your Name"
    git config --global user.email "your@email.com"    

#### authentication with git remotes

consult the GitHub article on [adding SSH
keys](https://help.github.com/articles/generating-ssh-keys/#platform-all)

#### create a repository on GitHub

-   copy the URL (something like
    <*git@github.com>:username/repositoryname.git\*)

#### in Rstudio:

-   file \> new project \> Version Control \> Git
-   paste the repository URL
-   give a directory name (use same as repository name)

-   go to the Rstudio pane which lists your files
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
