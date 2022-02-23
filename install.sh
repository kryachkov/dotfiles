#!/bin/sh

ROOT_PATH=`pwd -P`

echo "Link .gitconfig (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  ln -nfs $ROOT_PATH/.gitconfig $HOME/.gitconfig
  echo "Done"
fi

echo "Link .tmux.conf (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  ln -nfs $ROOT_PATH/.tmux.conf $HOME/.tmux.conf
  echo "Done"
fi

echo "Link .zshrh (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  ln -nfs $ROOT_PATH/.zshrc $HOME/.zshrc
  echo "Done"
fi

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
