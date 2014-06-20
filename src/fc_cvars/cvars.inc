struct cvar_s
	name dd ?
	.string dd ?
	flags dd ?
	value dd ?
	next dd ?
	def_val dd ?
ends

CVAR_NAME_DUMP_SIZE = 0
CVAR_DEFVAL_DUMP_SIZE = 0

CVAR_DUMP_NAME_OFFSET = 0
CVAR_DUMP_DEFV_OFFSET = 0

macro cvar name, def_val {
	name#.name dd cvarNameDump + CVAR_DUMP_NAME_OFFSET
	name#.string dd ?
	name#.flags dd ?
	name#.value dd ?
	name#.next dd ?	
	virtual at 0
		db PREFIX
		db `name, 0
		sizeof.#name = $
	end virtual
	repeat sizeof.#name
		virtual at 0
			db PREFIX
			db `name, 0
			load .b from % - 1
		end virtual
		store byte .b at cvarNameDump + CVAR_DUMP_NAME_OFFSET + % - 1
	end repeat
	CVAR_DUMP_NAME_OFFSET = CVAR_DUMP_NAME_OFFSET + sizeof.#name
	
	;saving memory, not storing string for default value if it has already been was stored.
	if cvar_aodv_offset_#def_val = -1
		cvar_aodv_offset_#def_val = CVAR_DUMP_DEFV_OFFSET
		virtual at 0
			db `def_val, 0
			sizeof.cvar_aodv_#def_val = $
		end virtual
		repeat sizeof.cvar_aodv_#def_val
			virtual at 0
				db `def_val, 0
				load .b from % - 1
			end virtual
			store byte .b at cvarDefValDump + CVAR_DUMP_DEFV_OFFSET + % - 1 
		end repeat
		CVAR_DUMP_DEFV_OFFSET = CVAR_DUMP_DEFV_OFFSET + sizeof.cvar_aodv_#def_val
	end if
	name#.def_val dd cvarDefValDump + cvar_aodv_offset_#def_val
}

macro define_cvar name, def_val {
	if CVAR_PREPROCESS = 1
		virtual at 0
			db PREFIX
			db `name, 0
			CVAR_NAME_DUMP_SIZE = CVAR_NAME_DUMP_SIZE + $
		end virtual
		if ~ defined DEF_CVAR_LIST_DEFV_#def_val
			virtual at 0
				db `def_val, 0
				CVAR_DEFVAL_DUMP_SIZE = CVAR_DEFVAL_DUMP_SIZE + $
			end virtual
			define DEF_CVAR_LIST_DEFV_#def_val 1
		end if
		cvar_aodv_offset_#def_val = -1
	else
		cvar name, def_val
	end if
}

;Calculate space for cvar string dump:
CVAR_PREPROCESS = 1
include 'cvar_list.inc'

cvarNameDump db CVAR_NAME_DUMP_SIZE dup ?
cvarDefValDump db CVAR_DEFVAL_DUMP_SIZE dup ?

;Define cvars
CVAR_PREPROCESS = 0
align 4
cvarList:
include 'cvar_list.inc'
cvarListEnd:

cvarMallocResult dd ?
RegVarMallocCallOrig dd ?
