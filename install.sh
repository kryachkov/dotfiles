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
  echo "Installing tpm"
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  ln -nfs $ROOT_PATH/.tmux.conf $HOME/.tmux.conf
  echo "Done"
fi

echo "Link .zshrc (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  ln -nfs $ROOT_PATH/.zshrc $HOME/.zshrc
  echo "Done"
fi

echo "Link Brewfile (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  ln -nfs $ROOT_PATH/Brewfile $HOME/Brewfile
  echo "Done"
fi

echo "Link foot.ini (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  mkdir -p $HOME/.config/foot
  ln -nfs $ROOT_PATH/foot.ini $HOME/.config/foot/foot.ini
  echo "Done"
fi

echo "Link sway config (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  mkdir -p $HOME/.config/sway
  ln -nfs $ROOT_PATH/sway_config $HOME/.config/sway/config
  echo "Done"
fi

echo "Bootstrap vim (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "Installing plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "Done"

  echo "Linking .vimrc..."
  ln -nfs $ROOT_PATH/.vimrc $HOME/.vimrc
  echo "Done"

  echo "Creating undo directory"
  mkdir -p $HOME/.vim/undo
  echo "Done"

  echo "Installing plugins..."
  vim +PlugInstall +qall
  echo "Done"
else
  echo "Skipping vim installation"
fi
