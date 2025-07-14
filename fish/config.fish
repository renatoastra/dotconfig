s"$GHOSTTY_RESOURCES_DIR"/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fishet fish_greeting ""

set -gx TERM xterm-256color

# theme
# set -g theme_color_scheme terminal-dark
# set -g fish_prompt_pwd_dir_length 1
#set -g theme_display_user yes
#set -g theme_hide_hostname no
#set -g theme_hostname always

# aliases
# eza (a modern replacement for ls)
alias ls 'eza --icons'
alias l 'eza -l --icons'
alias ll 'eza -la --icons' # a.k.a. la
alias lt 'eza --tree --level=2 --icons'

alias g git
alias c claude
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

# --- Plugins e integrações ---

# Carrega o fzf (fuzzy finder) e seus atalhos
fzf --fish | source

# Ativa o prompt do Starship
starship init fish | source

# pnpm
set -gx PNPM_HOME "/Users/renatocosta/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
