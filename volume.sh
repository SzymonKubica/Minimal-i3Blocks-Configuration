# Author: Szymon Kubica
#
is_pacmd_running="$(pacmd 2>&1 | awk '/No PulseAudio daemon running,/{print $1}')"

if [[ $is_pacmd_running == "No" ]]
then
  echo " 婢 "
  exit 0
fi

volume_percentage=" $(pactl get-sink-volume $(pacmd list-sinks |awk '/* index:/{print $3}') | awk '{print $5}')"
volume_level="${volume_percentage%%[%]*}"

# This command gets the active sink and checks if it is muted.
# It works by first getting the line number of where the description of the
# active sink starts. Then it uses sed to delete all lines up to that point
# in the output of pacmd list-sinks and then starts awk from there to find a line
# 'muted: yes/no' which will be the first such line after the active sink and
# so we know that it must refer to our active sink
#
is_muted="$(pacmd list-sinks | sed "1,$(pacmd list-sinks | awk '/* index:/{print NR}')d" | sed "15,\$d" | awk '/muted:/{print $2}')"

volume_icon=""

if [[ $((volume_level)) -gt 50 ]]
then
  volume_icon=""
elif [[ $((volume_level)) -lt 20 ]]
then
  volume_icon=""
fi

if [[ $is_muted == "yes" ]]
then
  volume_icon=""
fi

echo "$volume_percentage $volume_icon "
