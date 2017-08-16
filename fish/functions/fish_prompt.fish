function fish_prompt
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l normal (set_color normal)

    set branch (git branch 2>/dev/null | grep \* | sed 's/\*//g' | sed 's/ //g')

    echo "$blue┏╸$yellow"(prompt_pwd)

    if test -n "$branch";
        echo "$blue┣╸$yellow<$blue$branch$yellow>"
    end

    echo "$blue┗╸"
end
