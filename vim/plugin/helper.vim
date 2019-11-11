if exists("g:Helper_loadFlag")
    finish
endif

let g:Helper_loadFlag = 1
let t:Helper_specialFileNameDict = {}

function! Helper_jumpToSpecWindow(winid)
	execute a:winid . "wincmd w"
endfunc

function! Helper_jumpToSpecLine(lineid)
	let pos = [0, a:lineid, 0, 0]
	call setpos(".", pos)
endfunc

function! Helper_getCurLine()
    return getpos(".")[1]
endfunc

function! Helper_getCurColumn()
    return getpos(".")[2]
endfunc

function! Helper_getCurFileName()
let fileAbsPath = expand("%:p")
if has_key(t:Helper_specialFileNameDict, fileAbsPath)
    return t:Helper_specialFileNameDict[fileAbsPath]
endif
lua << EOF
    local splitStrFunc = function (str, delimeter)
        local find, sub, insert = string.find, string.sub, table.insert
        local res = {}
        local start, start_pos, end_pos = 1, 1, 1
        while true do
            start_pos, end_pos = find(str, delimeter, start, true)
            if not start_pos then
                break
            end
            insert(res, sub(str, start, start_pos - 1))
            start = end_pos + 1
        end
        insert(res, sub(str,start))
        return res
    end
    local fileAbsPath = vim.eval("fileAbsPath");
    splitRes = splitStrFunc(fileAbsPath, "/")
    local anw = ""
    local i = #splitRes
    while i >= 1 do
        if #splitRes[i] > 8 and i+3 <= #splitRes then
            if anw == "" then
                anw = string.sub(splitRes[i], 1, 5) .. "~"
            else
                anw = string.sub(splitRes[i], 1, 5) .. "~/" .. anw
            end
        else 
            if anw == "" then
                anw = splitRes[i]
            else
                anw = splitRes[i] .. "/" .. anw
            end
        end
        if #anw >= 30 and i+4 <= #splitRes then
            break;
        end
        i = i-1
    end
    vim.command("let showFilePath=\"" .. anw .. "\"")
EOF
return showFilePath
endfunc
