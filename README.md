# dotfiles
This repo is to store user configuration for applications in unix OS

# neovim
  * Install AstroNvim
  ```
    git clone https://github.com/AstroNvim/AstroNvim.git ~/.config/nvim
  ```
  * Install User Settings
  ```
  mkdir $HOME/.config/nvim/lua/user
  cd dotfiles
  ln -s $(pwd)/.config/nvim/* $HOME/.config/nvim/lua/user
  ```
  * Initialize AstroNvim
  ```
  nvim  --headless -c 'quitall'
  ```
  
# wezterm
  ```.wezterm.lua```
