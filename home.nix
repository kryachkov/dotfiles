{ config, pkgs, ... }:

let unstable = import <unstable> {};

in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "andfalk";
  home.homeDirectory = "/home/andfalk";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    unstable.awscli2
    unstable.firefox
    unstable.htop
    unstable.terraform
    unstable.tmux
    unstable.vim
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.zsh = {
    enable = true;
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = ["git"];
    theme = "minimal";
  };

  programs.kitty = {
    enable = true;
    package = unstable.kitty;
    font = {
      name = "Inconsolata";
      package = unstable.inconsolata;
      size = 16;
    };
    # theme = "Solarized Light";
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;
    };
  };

  programs.git = {
    enable = true;
    package = unstable.git;
    userEmail = "andre.falk@tutanota.com";
    userName = "André Falk";
  };
}
