# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 1. ENVIRONMENT VARIABLES & PATHS ---
# Define paths first so all subsequent tools can find them 
typeset -U path PATH

# Browser Configuration
export CHROME_EXECUTABLE="/usr/bin/google-chrome" 

# Android SDK Configuration
export ANDROID_SDK_ROOT="/opt/development_tools/AndroidStudio/sdks" 
export ANDROID_HOME=$ANDROID_SDK_ROOT 
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin 
export PATH="$HOME/.local/bin:$PATH" 

# Puro & Flutter Configuration
export PURO_ROOT="/opt/development_tools/puro" 
export PATH="$PATH:$PURO_ROOT/bin" 
export PATH="$PATH:$PURO_ROOT/shared/pub_cache/bin" 
export PATH="$PATH:$PURO_ROOT/envs/default/flutter/bin" 

# --- 2. ZIM FRAMEWORK INITIALIZATION ---
# Initialize Zimfw modules before other tool completions to avoid "already initialized" warnings
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim 
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then 
  source ${ZIM_HOME}/zimfw.zsh init 
fi
if [[ -z ${ZIM_INIT_DONE-} ]]; then
  # Starship prompt needs to be initialized before the transient prompt module loads.
  if (( ${+commands[starship]} )); then
    eval "$(starship init zsh)"
  fi
  # Transient prompt: hide previous prompts after each command
  TRANSIENT_PROMPT_TRANSIENT_PROMPT=''
  TRANSIENT_PROMPT_TRANSIENT_RPROMPT=''
  source ${ZIM_HOME}/init.zsh
  ZIM_INIT_DONE=1
fi

# --- 3. COMPATIBILITY LAYER ---
# Fixes "command not found: complete" by enabling Bash completion support in Zsh
autoload -Uz bashcompinit && bashcompinit

# --- 4. CUSTOM TOOLS & VERSION MANAGEMENT ---
# Load version managers and tool-specific scripts

# zoxide (smart cd)
if (( ${+commands[zoxide]} )); then
  eval "$(zoxide init zsh)"
fi

# asdf Version Manager
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  . "$HOME/.asdf/asdf.sh"
  [[ -f "$HOME/.asdf/completions/asdf.bash" ]] && . "$HOME/.asdf/completions/asdf.bash"
fi

# Dart CLI Completion
[[ -f /home/emanon/.dart-cli-completion/zsh-config.zsh ]] && . /home/emanon/.dart-cli-completion/zsh-config.zsh

# llmproxy (CLIPROXY)
export CLIPROXY_HOME="$HOME/cliproxyapi/llmproxy-config" 
[[ -f "$CLIPROXY_HOME/.llmproxy.zsh" ]] && source "$CLIPROXY_HOME/.llmproxy.zsh" 

# --- 5. PROMPT CONFIGURATION ---
# Powerlevel10k (disabled)
# [[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
