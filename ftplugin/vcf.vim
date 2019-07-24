function! VCFFold()
	let thisline = getline(v:lnum)
	if match(thisline, '^BEGIN') >= 0
		return ">1"
	endif
	return "="
endfunction
set foldmethod=expr
set foldexpr=VCFFold()

function! VCFFoldText()
	for i in range(v:foldstart, v:foldend)
		let l:thisline = getline(i)
		if match(l:thisline, '^N:') >= 0
			" return trim(substitute(substitute(thisline[2:], '\([^;]\+\);\(.*\)', '\2 \1', ''), ';', ' ', 'g'))
			let l:parts = split(l:thisline, ';')
			return substitute(join(l:parts[1:], " ") . l:parts[0][2:], '\s\+', ' ', 'g')
		endif
	endfor
	return "No Name"
endfunction

set foldtext=VCFFoldText()
