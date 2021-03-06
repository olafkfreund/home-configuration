scriptencoding utf-8
" Author: w0rp <devw0rp@gmail.com>
" Description: This file defines a handler function which ought to work for
" any program which outputs errors in the format that GCC uses.

let s:pragma_error = '#pragma once in main file'

function! s:IsHeaderFile(filename) abort
    return a:filename =~? '\v\.(h|hpp)$'
endfunction

function! s:RemoveUnicodeQuotes(text) abort
    let l:text = a:text
    let l:text = substitute(l:text, '[`´‘’]', '''', 'g')
    let l:text = substitute(l:text, '\v\\u2018([^\\]+)\\u2019', '''\1''', 'g')
    let l:text = substitute(l:text, '[“”]', '"', 'g')

    return l:text
endfunction

function! ale#handlers#gcc#HandleGCCFormat(buffer, lines) abort
    " Look for lines like the following.
    "
    " <stdin>:8:5: warning: conversion lacks type at end of format [-Wformat=]
    " <stdin>:10:27: error: invalid operands to binary - (have ‘int’ and ‘char *’)
    " -:189:7: note: $/${} is unnecessary on arithmetic variables. [SC2004]
    let l:pattern = '\v^([a-zA-Z]?:?[^:]+):(\d+):(\d+)?:? ([^:]+): (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        " Filter out the pragma errors
        if s:IsHeaderFile(bufname(bufnr('')))
        \&& l:match[5][:len(s:pragma_error) - 1] is# s:pragma_error
            continue
        endif

        " If the 'error type' is a note, make it detail related to
        " the previous error parsed in output
        if l:match[4] is# 'note'
            if !empty(l:output)
                let l:output[-1]['detail'] =
                \   get(l:output[-1], 'detail', '')
                \   . s:RemoveUnicodeQuotes(l:match[0]) . "\n"
            endif

            continue
        endif

        let l:item = {
        \   'lnum': str2nr(l:match[2]),
        \   'type': l:match[4] is# 'error' ? 'E' : 'W',
        \   'text': s:RemoveUnicodeQuotes(l:match[5]),
        \}

        if !empty(l:match[3])
            let l:item.col = str2nr(l:match[3])
        endif

        " If the filename is something like <stdin>, <nofile> or -, then
        " this is an error for the file we checked.
        if l:match[1] isnot# '-' && l:match[1][0] isnot# '<'
            let l:item['filename'] = l:match[1]
        endif

        call add(l:output, l:item)
    endfor

    return l:output
endfunction
