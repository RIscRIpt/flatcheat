macro cvar name, def_val {
	prefix_#name db MAX_PREFIX_LENGTH dup 0	;reserve for static prefix allocation
	name dd .name_address
	name_def_val dd .def_val_addr
}