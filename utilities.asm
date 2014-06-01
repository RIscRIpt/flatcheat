proc asm_memcpy
	mov eax, ecx
	and eax, 0011b ;3
	shr ecx, 2 ;div 4
	rep movsd
	mov ecx, eax
	rep movsb
	ret
endp

macro memcpy dest, src, len {
	mov edi, dest
	mov esi, src
	mov ecx, len
	stdcall asm_memcpy
}

proc FindBytePattern start, size, pattern, pattern_size
	mov edi, [start]
	mov edx, [size]
	mov eax, [pattern]
	mov al, [eax]
	inc [pattern]
	dec [pattern_size]
	
	.next:
	mov ecx, edx
	repne scasb
	jne .not_found
	
	mov edx, ecx
	mov ecx, [pattern_size]
	mov esi, [pattern]
	mov ebx, edi
	repe cmpsb
	je .found
	mov edi, ebx
	jmp .next
	
	.not_found:
	mov ebx, 1
	.found:
	mov eax, ebx
	dec eax
	ret
endp

macro FindRefWithPrefix start, size, prefix, prefix_size, address {
	sub esp, 4 + prefix_size
	if prefix_size = 1
		mov byte[esp], byte prefix
	else if prefix_size = 2
		mov word[esp], word prefix
	else if prefix_size = 4
		mov dword[esp], dword prefix
	else
		display 'Unsupported FindRefWithPrefix prefix_size', 13, 10
		err
	end if
	if address eqtype [0]
		mov eax, address
		mov dword[esp + prefix_size], eax
	else
		mov dword[esp + prefix_size], address
	end if
	mov eax, esp
	stdcall FindBytePattern, start, size, eax, 4 + prefix_size
	add esp, 4 + prefix_size
}

macro asm_instr name, value, size {
	ASM_INSTR_#name = value
	sizeof.ASM_INSTR_#name = size
}

asm_instr PUSH_DWORD,			0x68,	1
asm_instr PUSH_BYTE,			0x6A,	1
asm_instr CALL,					0xE8,	1
asm_instr JMP,					0xE9,	1
asm_instr MOV_ECX_DWORD_PTR,	0x0D8B, 2
asm_instr CALL_DWORD_PTR,		0x15FF,	2
asm_instr MOV_ESI_DWORD_PTR,	0x358B, 2

proc GetCmdByNameL szCmdName, cmdNameLen
	cinvoke Engine.pfnGetCmdList
	mov eax, [eax]
	virtual at eax
		.cmd command_s
	end virtual
	mov edx, [cmdNameLen]
	mov ebx, [szCmdName]
	.next:
	mov ecx, edx
	mov edi, ebx
	mov esi, [.cmd.name]
	repe cmpsb
	je .found
	mov eax, [.cmd.next]
	test eax, eax
	jnz .next
	.found:
	ret
endp
