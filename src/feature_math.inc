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

macro noftr features, cmd {
	local .ok
	.ok = 0
	irp feature, features \{
		if defined feature & feature
			.ok = 0
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
	display_space_align szCUR_PROC_NAME, 22
	if ~ size eq & size
		display_space_align <': ', `name>, 29
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
macro felse@feature \{
	endf
	if ~ defined name | ~ name
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

macro felse {
	felse@feature
	purge felse@feature
macro finish@feature \{
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

macro close_restore_cur_proc procname, flag, parmbytes, localbytes, reglist {
	if defined SHOW_COMPILED_PROC_SIZE & SHOW_COMPILED_PROC_SIZE
		display_space_align 'Compiled:', 16
		display_space_align szCUR_PROC_NAME, 51
		display '(', d=($ - procname), ' bytes)', 13, 10
	end if
	restore szCUR_PROC_NAME
}

prologue@proc equ prologue_define_cur_proc
close@proc equ close_restore_cur_proc

virtual at 0
	db PREFIX
	sizeof.PREFIX = $
end virtual

if sizeof.PREFIX <= 0
	display 13, 10, 13, 10
	display 9, 9, '   You can not use an empty prefix because of', 13, 10
	display 9, 9, 'client variable & cheat variable name conflicts.', 13, 10
	display 9, 9, '       Please edit PREFIX in features.ini', 13, 10
	display 13, 10, 13, 10
	err
end if

F_HOOK_CL_CREATEMOVE = 0
F_HOOK_HUD_REDRAW = 0
F_HOOK_HUD_ADDENTITY = 0

SCREEN_INFO_KREEDZ = 0

noftr <\
	SI_KZ_HSPEED,\
	SI_KZ_VSPEED,\
	SI_KZ_HEIGHT,\
0>, <SCREEN_INFO = 0> ;disable SCREEN_INFO if no SCREEN_INFO feature is enabled

anyftr <\
	SI_KZ_HSPEED,\
	SI_KZ_VSPEED,\
	SI_KZ_HEIGHT,\
0>, <SCREEN_INFO_KREEDZ = SCREEN_INFO> ;enable SCREEN_INFO_KREEDZ only if SCREEN_INFO is enabled

anyftr <\
	BHOP,\
	FASTRUN,\
	JUMPBUG,\
	STRAFE,\
	GROUND_STRAFE,\
0>, <F_HOOK_CL_CREATEMOVE = 1>

anyftr <\
	SCREEN_INFO,\
	FPS_BOOST_SKIP_HUD_REDRAW,\
0>, <F_HOOK_HUD_REDRAW = 1>

anyftr <\
	KNIFEBOT,\
0>, <F_HOOK_HUD_ADDENTITY = 1>
