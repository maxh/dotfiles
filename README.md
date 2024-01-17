# maxh's dotfiles

## Install

### Dotfiles

<https://www.atlassian.com/git/tutorials/dotfiles>

```sh
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:maxh/dotfiles.git $HOME/dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

### Other tools

```sh
brew install --cask kitty
brew install gh stats rg fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

Install LSPs with Mason within Neovim: `:Mason`.

### TypeScript debugging setup

Goal is to create `~/tools/vscode-js-debug`:

```
mkdir tools
cd tools
git clone git@github.com:microsoft/vscode-js-debug.git
cd vscode-js-debug
echo "nodejs 18.18.1" > .tool-versions
npm install
npx gulp vsDebugServerBundle
mv dist out
```

## Update

- `:Lazy sync`
- `:Mason` => `U`
- `:TSUpdate`

### After new asdf node version

```sh
npm install -g typescript-language-server graphql-language-service-cli
```
