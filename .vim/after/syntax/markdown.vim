vim9script

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml

# MarkdownLinkConceal ----------------------------------------------------{{{1
execute
    \ 'syntax region markdownLink matchgroup=markdownLinkDelimiter ' ..
    \ 'start="(" end=")" contains=markdownUrl keepend contained conceal'
execute
    \ 'syntax region markdownLinkText matchgroup=markdownLinkTextDelimiter ' ..
    \ 'start="!\=\[\%(\_[^][]*\%(\[\_[^][]*\]\_[^][]*\)*]\%([[(]\)\)\@=" ' ..
    \ 'end="\]\%([[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite ' ..
    \ 'contains=@markdownInline,markdownLineStart concealends'

# Checkbox Syntax Fix ----------------------------------------------------{{{1
# Correct the checkbox syntax highlighting issue from
# fix: https://github.com/tpope/vim-markdown/issues/212

# Allow user to customize checkbox symbols, default: [ ] [.] [o] [O] [x] [X] [-]
g:markdown_checkbox_symbols = get(g:, 'markdown_checkbox_symbols', ' .oOxX-')

# Build regex pattern for list item + checkbox
var list_pat = '\%(\d\+\.\|[aAiI]\.\|[*+-]\)'
var checkbox_chars = escape(g:markdown_checkbox_symbols, '^-[]')
var checkbox_pat = '^\s*' .. list_pat .. '\s*\[[' .. checkbox_chars .. ']\]'

# Define checkbox syntax group
execute('syn match markdownTodo "' .. checkbox_pat .. '" contains=markdownTodoDone')

# Match the symbol inside the checkbox
execute('syn match markdownTodoDone "[' .. checkbox_chars .. ']" containedin=markdownTodo contained')

# Optional: highlight style (comment out to use theme default)
hi def link markdownTodo         markdownListMarker
hi def link markdownTodoDone     markdownBold
