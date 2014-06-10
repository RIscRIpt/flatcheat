macro string name, data {
	name db data, 0
	sizeof.#name = $ - name
}

macro jmpcall dest, [arg] { ; push dword arguments and jump to destination
	common
    if ~ arg eq
		reverse
		pushd arg
	common
	end if
    jmp dest
}

macro display_feature name {
	local .tabs
	display szCUR_PROC_NAME
	;calculate number of required tabs, assuming length of szCUR_PROC_NAME won't be >= 24
	virtual at 0
		db `szCUR_PROC_NAME
		.tabs = (24 - $) / 4
	end virtual
	if .tabs > 0
		repeat .tabs
			display 9 ;horizontal tab
		end repeat
	else
		display 32 ;space
	end if
	display ': ', `name, 13, 10
}

macro feature name {
	if defined name & name
		.#name:
		if defined COMPILING_FEATURE & COMPILING_FEATURE
			display 'Compiling:', 9
			display_feature name
		end if
macro finish@feature \{
		.end_#name:
		if defined COMPILED_FEATURE & COMPILED_FEATURE
			display 'Compiled:', 9
			display_feature name
		end if
	end if
\}
}

macro endf {
	finish@feature
	purge finish@feature
}

macro prologue_define_cur_proc procname, flag, parmbytes, localbytes, reglist {
	define szCUR_PROC_NAME `procname
	prologuedef procname, flag, parmbytes, localbytes, reglist
}

macro epilogue_restore_cur_proc procname, flag, parmbytes, localbytes, reglist {
	restore szCUR_PROC_NAME
	epiloguedef procname, flag, parmbytes, localbytes, reglist
}

prologue@proc equ prologue_define_cur_proc
epilogue@proc equ epilogue_restore_cur_proc
