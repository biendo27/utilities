# Utilities

Personal shell configuration files for Zsh and Starship.

## Contents
- `.zshrc` Zsh configuration
- `.zimrc` Zim configuration
- `starship.toml` Starship prompt configuration

## Usage
Review and adjust the files for your machine, then symlink them:

```sh
mkdir -p ~/.config
ln -sfn "$PWD/.zshrc" ~/.zshrc
ln -sfn "$PWD/.zimrc" ~/.zimrc
ln -sfn "$PWD/starship.toml" ~/.config/starship.toml
```
