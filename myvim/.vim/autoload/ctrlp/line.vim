" =============================================================================
" File:  autoload       autoload/ctrlp/line.vim
" Description:   Line extension
" Author:        Kien Nguyen <github.com/kien>
" =============================================================================

" Init {{{1
if exists('g:loaded_ctrlp_line') && g:loaded_ctrlp_line
	fini
en
let g:loaded_ctrlp_line = 1

cal add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp#line#init()',
	\ 'accept': 'ctrlp#line#accept',
	\ 'lname': 'lines',
	\ 'sname': 'lns',
	\ 'type': 'tabe',
	\ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Utilities {{{1
fu! s:syntax()
	if !ctrlp#nosy()
		cal ctrlp#hicheck('CtrlPBufName', 'Directory')
		cal ctrlp#hicheck('CtrlPTabExtra', 'Comment')
		sy match CtrlPBufName '\t|\zs[^|]\+\ze|\d\+:\d\+|$'
		sy match CtrlPTabExtra '\zs\t.*\ze$' contains=CtrlPBufName
	en
endf
" Public {{{1
fu! ctrlp#line#init()
	let [bufs, lines] = [ctrlp#buffers('id'), []]
	for bufnr in bufs
		let [lfb, bufn] = [getbufline(bufnr, 1, '$'), bufname(bufnr)]
		let lfb = lfb == [] ? ctrlp#utils#readfile(fnamemodify(bufn, ':p')) : lfb
		cal map(lfb, 'tr(v:val, ''	'', '' '')')
		let [linenr, len_lfb, buft] = [1, len(lfb), fnamemodify(bufn, ':t')]
		wh linenr <= len_lfb
			let lfb[linenr - 1] .= '	|'.buft.'|'.bufnr.':'.linenr.'|'
			let linenr += 1
		endw
		cal extend(lines, filter(lfb, 'v:val !~ ''^\s*\t|[^|]\+|\d\+:\d\+|$'''))
	endfo
	cal s:syntax()
	retu lines
endf

fu! ctrlp#line#accept(mode, str)
	let info = matchlist(a:str, '\t|[^|]\+|\(\d\+\):\(\d\+\)|$')
	let bufnr = str2nr(get(info, 1))
	if bufnr
		cal ctrlp#acceptfile(a:mode, bufname(bufnr), get(info, 2))
	en
endf

fu! ctrlp#line#id()
	retu s:id
endf
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2
