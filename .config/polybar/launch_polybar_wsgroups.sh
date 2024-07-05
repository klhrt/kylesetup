#!/bin/bash
while IFS='' read -r monitor; do
    i3_mod_hook="i3-workspace-groups-client polybar-hook --monitor '{$monitor}'"
    I3_MOD_HOOK="$i3_mod_hook" polybar example --config=~/.config/polybar/config.ini&
done < <(polybar --list-monitors | cut -d':' -f1)
