function fish_prompt
    set -l yellow (set_color yellow)
    set -l normal (set_color normal)

    echo $yellow (prompt_pwd) ">> "
end
