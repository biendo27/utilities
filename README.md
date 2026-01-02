# Utilities

My setup for Zimfw + Starship configuration.

## Contents
- `.zshrc` Zsh configuration
- `.zimrc` Zim configuration
- `starship.toml` Starship prompt configuration

## Usage
Follow these steps:

1. Pick a Nerd Font version of your preferred terminal font (look for "Nerd Font" or "Nerd Font Mono").
   If you want strict fixed-width, choose a "Mono" variant.
2. Install it from the Nerd Fonts site.
3. Set your terminal to use that Nerd Font (icons and symbols need it).
4. Copy the config files:

   ```sh
   mkdir -p ~/.config
   cp -f "$PWD/.zshrc" ~/.zshrc
   cp -f "$PWD/.zimrc" ~/.zimrc
   cp -f "$PWD/starship.toml" ~/.config/starship.toml
   ```

5. Restart your terminal (or run `exec zsh`).

Nerd Fonts download page: https://www.nerdfonts.com/font-downloads
