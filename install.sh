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

echo "Link sway configs (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  mkdir -p $HOME/.config/sway
  ln -s $ROOT_PATH/sway_config.d $HOME/.config/sway/config.d
  echo "Done"
fi

echo "Link swaylock config (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  mkdir -p $HOME/.config/swaylock
  ln -nfs $ROOT_PATH/swaylock_config $HOME/.config/swaylock/config
  echo "Done"
fi

echo "Link mpd config (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  mkdir -p $HOME/.config/mpd
  ln -nfs $ROOT_PATH/mpd.conf $HOME/.config/mpd/mpd.conf
  echo "Done"
fi

echo "Link waybar config (y/n)?"
read answer
if echo "$answer" | grep -iq "^y" ;then
  mkdir -p $HOME/.config/waybar
  ln -nfs $ROOT_PATH/waybar/config.jsonc $HOME/.config/waybar/config.jsonc
  ln -nfs $ROOT_PATH/waybar/style.css $HOME/.config/waybar/style.css
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
