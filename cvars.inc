CVAR_NAME_DUMP_SIZE = 0
CVAR_DEFVAL_DUMP_SIZE = 0

macro cvar name, def_val {
	name#.value dd ?
	name#.string dd ?
	name dd CVAR_NAME_DUMP_SIZE
	virtual at 0
		db `name, 0
		sizeof.#name = $
	end virtual
	repeat sizeof.#name
		virtual at 0
			db `name, 0
			load .b from % - 1
		end virtual
		store byte .b at cvarNameDump + CVAR_NAME_DUMP_SIZE + % - 1 
	end repeat
	CVAR_NAME_DUMP_SIZE = CVAR_NAME_DUMP_SIZE + sizeof.#name
	if defined cvar_aodv_#def_val ;saving memory, not storing string for default value if it already was stored.
		name#.def_val dd cvar_aodv_#def_val
	else
		define cvar_aodv_#def_val CVAR_DEFVAL_DUMP_SIZE
		virtual at 0
			db `def_val, 0
			sizeof.cvar_aodv_#def_val = $
			CVAR_DEFVAL_DUMP_SIZE = CVAR_DEFVAL_DUMP_SIZE + $
		end virtual
		repeat sizeof.cvar_aodv_#def_val
			virtual at 0
				db `def_val, 0
				load .b from % - 1
			end virtual
			store byte .b at cvarDefValDump + CVAR_DEFVAL_DUMP_SIZE + % - 1 
		end repeat
	end if
}

cvarNameDump db CVAR_NAME_DUMP_SIZE dup ?
cvarDefValDump db CVAR_DEFVAL_DUMP_SIZE dup ?

cvarList:
	cvar bhop, 1
	cvar bhop_nsd, 1
	
	cvar jumpbug, 0
