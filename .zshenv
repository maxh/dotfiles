# https://unix.stackexchange.com/a/197135
# Defined here so accessible in Vim shell.


# Run 's add new feature' to make a new commit.
s() {
    git add .
    git commit -am "$*"
}

# Run 'p' to push commits.
alias p="git push"

# Run 'm' to checkout the main branch.
alias m="git checkout main"

# Run 'mpr' to create a new pull request (requires gh cmd line util).
alias mpr="git push -u origin HEAD && gh pr create -w"
