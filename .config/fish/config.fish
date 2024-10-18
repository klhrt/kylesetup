if status is-interactive
    # Commands to run in interactive sessions can go here
end

function typetest
    ttyper -w 100 -l english1000
end

source ~/.asdf/asdf.fish

# pnpm
set -gx PNPM_HOME "/home/kyle/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

fish_add_path /home/kyle/.millennium/ext/bin
