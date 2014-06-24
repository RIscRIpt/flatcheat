macro chkftr features, cmd {
	local .ok
	.ok = 1
	irp feature, features \{
		if ~ defined feature | ~ feature
			.ok = 0
		end if
	\}
	if .ok = 1
		cmd
	end if
}

macro anyftr features, cmd {
	local .ok
	.ok = 0
	irp feature, features \{
		if defined feature & feature
			.ok = 1
		end if
	\}
	if .ok = 1
		cmd
	end if
}

macro display_space_align str, count {
	display str
	virtual at 0
		db str
		if count > $
			repeat count - $
				display 32
			end repeat
		else
			display 32
		end if
	end virtual
}

macro display_feature name, size {
	local .spaces, .tmp
	display_space_align szCUR_PROC_NAME, 24
	if ~ size eq
		display_space_align <': ', `name>, 24
		display '(', d=(.end_#name - .#name), ' bytes)'
	else
		display ': ', `name
	end if
	display 13, 10
}

macro feature name {
	if defined name & name
		.#name:
		if defined COMPILING_FEATURE & COMPILING_FEATURE
			display_space_align 'Compiling:', 16
			display_feature name
		end if
macro finish@feature \{
		.end_#name:
		if defined COMPILED_FEATURE & COMPILED_FEATURE
			display_space_align 'Compiled:', 16
			display_feature name, COMPILED_FEATURE_SIZE
		end if
	end if
\}
}

macro inline_feature name, cmd {
	if defined name & name
		if (defined COMPILING_FEATURE & COMPILING_FEATURE) | (defined COMPILED_FEATURE & COMPILED_FEATURE)
			display_space_align 'Added:', 16
			display_feature name
		end if
		cmd
	end if
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

virtual at 0
	db PREFIX
	sizeof.PREFIX = $
end virtual

anyftr <\
	BHOP,\
	JUMPBUG,\
	STRAFE,\
	GROUND_STRAFE,\
0>, <F_HOOK_CL_CREATEMOVE = 1>

anyftr <\
	SCREEN_INFO,\
0>, <F_HOOK_HUD_REDRAW = 1>
