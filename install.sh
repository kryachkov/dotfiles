#!/bin/sh

ROOT_PATH=`pwd -P`

echo "Linking .gitconfig..."
ln -nfs $ROOT_PATH/.gitconfig $HOME/.gitconfig
echo "Done"

echo "Linking .tmux.conf..."
ln -nfs $ROOT_PATH/.tmux.conf $HOME/.tmux.conf
echo "Done"

echo "Linking .zshrc..."
ln -nfs $ROOT_PATH/.zshrc $HOME/.zshrc
echo "Done"

echo -n "Bootstrap vim (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "Installing plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "Done"

  echo "Linking .vimrc..."
  ln -nfs $ROOT_PATH/.vimrc $HOME/.vimrc
  echo "Done"

  echo "Installing plugins..."
  vim +PlugInstall +qall
  echo "Done"
else
  echo "Skipping vim installation"
fi
