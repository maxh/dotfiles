# https://unix.stackexchange.com/a/197135
# Defined here so accessible in Vim shell.

u() {
    git add .
    git commit -am "$*"
    git push
}

e() {
  git diff main --name-only | grep "\.ts" | xargs yarn eslint --fix --no-error-on-unmatched-pattern
}

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
