function fish_prompt
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l normal (set_color normal)

    set branch (git branch 2>/dev/null | grep \* | sed 's/\*//g' | sed 's/ //g')

    if set -q branch
        echo $yellow(prompt_pwd) [$blue$branch$yellow] ">> "
    else
        echo $yellow (prompt_pwd) ">> "
    end
end
