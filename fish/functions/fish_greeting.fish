function fish_greeting
    set -l color (set_color -o magenta)
    set -l highlight (set_color -o yellow)

    echo $color":"
    echo $color":  when two opponents meet"
    echo $color":     the one without an enemy"
    echo $color":     will surely triumph"
    echo $color":"
end
