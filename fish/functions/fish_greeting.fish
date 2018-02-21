function fish_greeting
    set -l color (set_color -o magenta)
    set -l highlight (set_color -o yellow)

    echo $color":"
    echo $color":  the obstacle is the way"
    echo $color":"
end
