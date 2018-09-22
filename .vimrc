execute pathogen#infect()
set number
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_extsyntax = {' .md': 'markdown', ' .markdown': 'markdown', ' .down': 'markdown'}
map <leader>h : InstantMarkdownPreview<CR>
" vimwiki/vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 
		\ 'syntax': 'markdown', 
		\ 'css_file' : '$HOME/vimwiki/css/styles.css',
		\ 'ext': '.md',
		\ 'custom_wiki2html': '$HOME/vimwiki/converter/wiki2html.sh'}]
let g:instant_markdown_autostart = 0
