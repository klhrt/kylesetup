#!/bin/sh


mute_status=$(pactl get-source-mute @DEFAULT_SOURCE@)

echo $mute_status