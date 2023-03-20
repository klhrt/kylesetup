if type "xrandr"; then
  killall polybar
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=~/.config/polybar/config.ini --reload example &
  done
else
  polybar --reload example &
fi
