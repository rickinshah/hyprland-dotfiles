alias ls='eza -1 --color=always --icons=always --hyperlink --group-directories-first'
alias cat='bat'
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    direnv hook fish | source
    # pokemon-colorscripts --no-title -r
    fastfetch

end
