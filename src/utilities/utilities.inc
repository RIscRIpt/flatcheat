string szErr_VirtualProtect_s, 'VirtualProtect failed.'

string szErr_ExecTooLongLine,	'Error: ', 'Exec failed to process long line "%s":%d (it will be ignored)', 13, 10
string szErr_ExecExBufOverflow,	'Error: ', 'Exec failed to replace pfx# ("%s"), extension buffer overflow', 13, 10
string szErr_ExecFailOpen,		'Error: ', 'Exec failed to open file "%s" [Error: #%08x]', 13, 10
string szErr_ExecFailHAlloc,	'Error: ', 'Exec failed to allocate memory for reading buffer [Error: #%08x]', 13, 10
string szErr_ExecFailRead,		'Error: ', 'Exec failed to read file "%s" [Error: #%08x]', 13, 10

align 4
divTable: ;used in itoa
	dd 1000000000
	dd 100000000
	dd 10000000
	dd 1000000
	dd 100000
	dd 10000
	dd 1000
	dd 100
	dd 10
	dd 1
divTableEnd:
