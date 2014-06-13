struct command_s
	next	dd ?
	name	dd ?
	func	dd ?
	flag	dd ? ;If flag 0bit is 1, this structure will be passed to Z_Free
ends

CMD_NAME_DUMP_SIZE = 0
CMD_DUMP_NAME_OFFSET = 0

macro define_switch name {
	define_cmd name, p
	define_cmd name, m
}

macro define_cmd name, switch {
	if CMD_PREPROCESS = 1
		virtual at 0
			if switch eq p
				db '+'
			else if switch eq m
				db '-'
			end if
			db PREFIX
			db `name, 0
			CMD_NAME_DUMP_SIZE = CMD_NAME_DUMP_SIZE + $
		end virtual
	else
		switch#name#.next dd ?
		switch#name#.name dd cmdNameDump + CMD_DUMP_NAME_OFFSET
		switch#name#.func dd Command_#name
		switch#name#.flag dd 0
		virtual at 0
			if switch eq p
				db '+'
			else if switch eq m
				db '-'
			end if
			db PREFIX
			db `name, 0
			sizeof.#name = $
		end virtual
		repeat sizeof.#name
			virtual at 0
				if switch eq p
					db '+'
				else if switch eq m
					db '-'
				end if
				db PREFIX
				db `name, 0
				load .b from % - 1
			end virtual
			store byte .b at cmdNameDump + CMD_DUMP_NAME_OFFSET + % - 1
		end repeat
		CMD_DUMP_NAME_OFFSET = CMD_DUMP_NAME_OFFSET + sizeof.#name
	end if
}

;Calculate space for cmd string dump:
CMD_PREPROCESS = 1
include 'cmd_list.inc'

cmdNameDump db CMD_NAME_DUMP_SIZE dup ?

;Define cmds
CMD_PREPROCESS = 0
align 4
cmdList:
include 'cmd_list.inc'
cmdListEnd:

cmdMallocResult dd ?
RegCmdMallocCallOrig dd ?
