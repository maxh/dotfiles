# https://unix.stackexchange.com/a/197135
# Defined here so accessible in Vim shell.

# "update" => add, commit, push
# Eg: u add feature
u() {
    git add .
    git commit -am "$*"
    git push
}

# "eslint" => run eslint fix on all .ts files, add, commit, push
e() {
  yarn style:eslint:fix-diff
  git add .
  git commit -am "fix lint"
  git push
}

# "save" => add, commit
s() {
    git add .
    git commit -am "$*"
}

# "push" => push
alias p="git push"

# Run 'm' to checkout the main branch.
alias m="git checkout main"

# Run 'mpr' to create a new pull request (requires gh cmd line util).
alias mpr="git push -u origin HEAD && gh pr create -w"

if [ -f "/Users/maxheinritz/.cargo/env" ]; then
  export PATH="$HOME/.cargo/env:$PATH"
fi

alias run_prisma_lint="node -c "
