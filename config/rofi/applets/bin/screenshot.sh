#!/usr/bin/env bash
## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
## Applets : Screenshot (Wayland Version)

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Screenshot'
mesg="DIR: $(xdg-user-dir PICTURES)/Screenshots"

if [[ "$theme" == *'type-1'* ]]; then
    list_col='1'
    list_row='4'
    win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
    list_col='1'
    list_row='4'
    win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
    list_col='1'
    list_row='4'
    win_width='520px'
elif [[ "$theme" == *'type-2'* || "$theme" == *'type-4'* ]]; then
    list_col='4'
    list_row='1'
    win_width='670px'
fi

layout=$(grep 'USE_ICON' "${theme}" | cut -d'=' -f2)

if [[ "$layout" == 'NO' ]]; then
    option_1=" Capture Desktop"
    option_2=" Capture Area"
    option_3=" Capture in 5s"
    option_4=" Capture in 10s"
else
    option_1=""
    option_2=""
    option_3=""
    option_4=""
fi

rofi_cmd() {
    rofi -theme-str "window {width: $win_width;}" \
         -theme-str "listview {columns: $list_col; lines: $list_row;}" \
         -theme-str 'textbox-prompt-colon {str: "";}' \
         -dmenu \
         -p "$prompt" \
         -mesg "$mesg" \
         -markup-rows \
         -theme ${theme}
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}.png"

mkdir -p "$dir"

notify_view() {
    dunstify -u low --replace=699 "Screenshot Saved to ${dir}/${file}"
}

copy_shot () {
    tee "$file" | wl-copy
}

countdown () {
    for sec in $(seq "$1" -1 1); do
        dunstify -t 1000 --replace=699 "Taking shot in : $sec"
        sleep 1
    done
}

shotnow () {
    cd "$dir" && sleep 0.5 && grim - | copy_shot
    notify_view
}

shot5 () {
    countdown '5'
    sleep 1 && cd "$dir" && grim - | copy_shot
    notify_view
}

shot10 () {
    countdown '10'
    sleep 1 && cd "$dir" && grim - | copy_shot
    notify_view
}

shotarea () {
    cd "$dir"
    wayfreeze & PID=$!
    sleep 0.1
    grim -g "$(slurp)" - | tee "$file" | wl-copy --type image/png
    kill "$PID"
    notify_view
}

run_cmd() {
    case "$1" in
        --opt1) shotnow ;;
        --opt2) shotarea ;;
        --opt3) shot5 ;;
        --opt4) shot10 ;;
    esac
}

chosen="$(run_rofi)"
case "$chosen" in
    "$option_1") run_cmd --opt1 ;;
    "$option_2") run_cmd --opt2 ;;
    "$option_3") run_cmd --opt3 ;;
    "$option_4") run_cmd --opt4 ;;
esac

