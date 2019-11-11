if exists("g:MultiSearch_loadFlag")
    finish
endif

let g:MultiSearch_loadFlag = 1

function! MultiSearch_GetSearchPatterns()
    if !exists("b:MultiSearch_allPatternList")
        return ''
    endif
    let patterns = ''
    let sperator = ''
    for pat in b:MultiSearch_allPatternList
        let patterns = patterns . sperator . pat
        let sperator = '\|'
    endfor
    return patterns
endfunction

function! MultiSearch_Search(backward)
    if !exists("b:MultiSearch_MatchAddID")
        let b:MultiSearch_MatchAddID = -1
    endif
    let pats = MultiSearch_GetSearchPatterns()
    highlight MultiSearchGroup cterm=NONE ctermfg=grey ctermbg=yellow
    if b:MultiSearch_MatchAddID != -1
        call matchdelete(b:MultiSearch_MatchAddID)
    endif
    let b:MultiSearch_MatchAddID = matchadd("MultiSearchGroup", pats)
    let flag = "w"
    if a:backward == 1
        let flag = flag . "b"
    endif
    call search(pats, flag)
endfunction

function! MultiSearch_DelIndex(ind)
    if !exists("b:MultiSearch_allPatternList")
        let b:MultiSearch_allPatternList = []
    endif
    let patCnt = len(b:MultiSearch_allPatternList)
    if a:ind < 0 || a:ind >= patCnt
        return
    endif
    call remove(b:MultiSearch_allPatternList, a:ind)
    call MultiSearch_Search(0)
endfunction

function! MultiSearch_AddVisualSelect(keyword)
    v_y
    let text = getreg(0)
    if a:keyword == 1
        let text = "\\<".text."\\>"
    endif
    call MultiSearch_Add(text)
endfunction

function! MultiSearch_Add(p)
    if !exists("b:MultiSearch_allPatternList")
        let b:MultiSearch_allPatternList = []
    endif
    let isExist = 0
    for pattern in b:MultiSearch_allPatternList
        if pattern == a:p
            let isExist = 1
            break
        endif
    endfor
    if isExist == 0
        call add(b:MultiSearch_allPatternList, a:p)
        call MultiSearch_Search(0)
    endif
endfunction

function! MultiSearch_List()
    if !exists("b:MultiSearch_allPatternList")
        let b:MultiSearch_allPatternList = []
    endif
    if len(b:MultiSearch_allPatternList) <= 0
        echom "no patterns"
        return
    endif
    let id = 0
    for pattern in b:MultiSearch_allPatternList
        echom id":"pattern
        let id = id+1
    endfor
endfunction
