if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.yml setfiletype yaml
    au! BufRead,BufNewFile *.yaml setfiletype yaml
augroup END
