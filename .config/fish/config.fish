alias ls='eza -1 --color=always --icons=always --hyperlink --group-directories-first'
alias cat='bat'
direnv hook fish | source
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    fastfetch
    stty -icanon -echo
    dd bs=1 count=1 >/dev/null 2>&1
    stty icanon echo
end
