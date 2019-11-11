if exists("g:Hinter_loadFlag")
    finish
endif

let g:Hinter_loadFlag = 1
let g:Hinter_line = split(execute("set lines?"), "=")[1]
let g:Hinter_column = split(execute("set columns?"), "=")[1]

function Hinter_notifaction(data) 
    call popup_notification(a:data, #{ pos:"botleft", line: g:Hinter_line - 4, col: 6, borderchars: ['▪', '◂', '▪', '▸', '▪', '▪', '▪', '▪']})
endfunc

function Hinter_showPrefixWorkDirectory()
lua << EOF
    local obj = io.popen("pwd")
    local path=obj:read("*all"):sub(1,-2)
    obj:close()
    vim.command("let l:curdir = " .. "\"" .. path .. "\"");
EOF
    call Hinter_notifaction(l:curdir)
endfunc

function! Hinter_switchBufferCallback(id, result)
    let bufnr = winbufnr(a:id)
    let res = getbufline(bufnr, a:result, a:result)
    if len(res) != 1
        return
    endif
    call execute(split(res[0])[0]."buffer")
endfunction

function! Hinter_switchBuffer()
    call popup_menu(split(execute("buffers"), "\n"),
                \   #{  pos:"botright",
                \       line: g:Hinter_line-2,
                \       col: g:Hinter_column-1,
                \       callback: 'Hinter_switchBufferCallback',
                \       borderhighlight: ['PopupBorder'],
                \       borderchars: ['▪', '◂', '▪', '▸', '▪', '▪', '▪', '▪'],
                \       padding: [0, 0, 0, 0],
                \       border: [0, 0, 0, 0],
                \       highlight: 'PopupText'
                \ })
endfunction
