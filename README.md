<https://www.atlassian.com/git/tutorials/dotfiles>

```sh
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:maxh/dotfiles.git $HOME/dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
