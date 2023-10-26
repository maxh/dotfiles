<https://www.atlassian.com/git/tutorials/dotfiles>

```sh
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:maxh/dotfiles.git $HOME/dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

Also

```
brew install gh stats
```

## On each separate asdf node version

- `npm install -g typescript-language-server`

## Manual installation on each machine

To install:

- `brew install rg`
- LSPs with Mason - `:Mason`
- For working with ASDF may need separate `npm i -g graphql-language-service-cli`

### TypeScript debugging setup

~/tools/vscode-js-debug

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

## Updating non-explicit dependencies

- `:Lazy sync`
- `:Mason` => `U`
- `:TSUpdate`
