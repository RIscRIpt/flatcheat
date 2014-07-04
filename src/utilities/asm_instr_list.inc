macro asm_instr name, value, size {
	ASM_INSTR_#name = value
	sizeof.ASM_INSTR_#name = size
}

asm_instr PUSH_EBP,				0x55,	1
asm_instr PUSH_DWORD,			0x68,	1
asm_instr PUSH_BYTE,			0x6A,	1
asm_instr CALL,					0xE8,	1
asm_instr JMP,					0xE9,	1
asm_instr JMP_SHORT,			0xEB,	1
asm_instr JNE,					0x75,	1
asm_instr MOV_ECX_DWORD,		0xB9,	1
asm_instr MOV_EDX_DWORD,		0xBA,	1
asm_instr MOV_EDI_DWORD,		0xBF,	1
asm_instr MOV_EAX_DWORD_PTR, 	0xA1,	1
asm_instr MOV_DWORD_PTR_EAX,	0xA3,	1
asm_instr MOV_ECX_DWORD_PTR,	0x0D8B,	2
asm_instr CALL_DWORD_PTR,		0x15FF,	2
asm_instr MOV_ESI_DWORD_PTR,	0x358B,	2
asm_instr MOV_DWORD_PTR_BYTE, 	0x05C7,	2
asm_instr FLD_DWORD_PTR,		0x05D9,	2
asm_instr FLD_QWORD_PTR,		0x05DD,	2
