# Author: Szymon Kubica
output="$(swaymsg input "1:1:AT_Translated_Set_2_keyboard" xkb_switch_layout next &&
swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')"
language_name="$(echo $output | awk '/success/{print $7 $8}' )"
echo $language_name
