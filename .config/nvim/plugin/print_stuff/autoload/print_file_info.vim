" TODO: Improve
function! print_file_info#print_file_info() abort
	echo noscrollbar#statusline(&columns,'■','◫',['◧'],['◨'])
	echo 'Working Directory: ' . getcwd()
	echo 'File: ' . expand('%:.')
endfunction
