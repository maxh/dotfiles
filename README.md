<https://www.atlassian.com/git/tutorials/dotfiles>

```sh
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:maxh/dotfiles.git $HOME/dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

## On each separate asdf node version

- npm install -g typescript-language-server

## Manual installation on each machine

To install:

- LSPs with Mason

### TypeScript debugging setup

~/tools/vscode-js-debug

```
mkdir tools
cd tools
git clone git@github.com:microsoft/vscode-js-debug.git
cd vscode-js-debug
npm install
npx gulp vsDebugServerBundle
mv dist out
```
