# Open tmux in every new non-tmux terminal.
[[ -z "$TMUX" ]] && exec tmux attach

# Wisdom from a moose.
#fortune -s | cowsay -f moose

