# Author: Szymon Kubica
percentage=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}')
state=$(upower -i $(upower -e | grep 'BAT') | grep -E "state" | awk '{print $2}')

charge_level="${percentage%%[%]*}"

if [[ $((charge_level)) -lt 5 && "$state" == "discharging" ]]
then
  notify-send "Battery level critical: ${charge_level}% Please charge immediately!"
elif [[ $((charge_level)) -lt 15 && "$state" == "discharging" ]]
then
  notify-send -a "sway" "Battery level is low: ${charge_level}% Please connect charger."
fi

battery_icon=""

if [[ $((charge_level)) -gt 90 ]]
then
  battery_icon=""
elif [[ $((charge_level)) -gt 60 ]]
then
  battery_icon=""
elif [[ $((charge_level)) -gt 40 ]]
then
  battery_icon=""
elif [[ $((charge_level)) -gt 10 ]]
then
  battery_icon=""
else
  battery_icon=""
fi

if [[ "$state" == "charging" ]]
then
  battery_icon=" $battery_icon"
fi

echo "$percentage $battery_icon "
