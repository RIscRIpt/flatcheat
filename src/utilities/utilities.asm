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

proc FindRefCallAddr start, size, address
	mov edi, [start]
	mov edx, [address]
	mov ecx, [size]
	sub edx, 4
	mov al, ASM_INSTR_CALL
	
	.cont:
	repne scasb
	jne .not_found
	
	mov ebx, edx
	sub ebx, edi
	cmp dword[edi], ebx
	je .found
	
	;Assume E8 byte cannot be found less than 5 bytes
	;before another real call instruction
	add edi, 4
	jmp .cont
	
	.not_found:
	mov edi, 1
	.found:
	lea eax, [edi - 1]
	ret
endp

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
	
	.cont:
	repe cmpsb
	je .found

	cmp byte[esi - 1], 0xFF
	je .cont
	
	mov edi, ebx
	jmp .next
	
	.not_found:
	mov ebx, 1
	.found:
	lea eax, [ebx - 1]
	ret
endp

macro FindRefWithPrefix start, size, prefix, prefix_size, address {
	sub esp, 4 + prefix_size
	if prefix_size = 0
	else if prefix_size = 1
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

asm_instr PUSH_EBP,				0x55,	1
asm_instr PUSH_DWORD,			0x68,	1
asm_instr PUSH_BYTE,			0x6A,	1
asm_instr CALL,					0xE8,	1
asm_instr JMP,					0xE9,	1
asm_instr JMP_SHORT,			0xEB,	1
asm_instr JNE,					0x75,	1
asm_instr MOV_EAX_DWORD_PTR, 	0xA1,	1
asm_instr MOV_ECX_DWORD_PTR,	0x0D8B,	2
asm_instr CALL_DWORD_PTR,		0x15FF,	2
asm_instr MOV_ESI_DWORD_PTR,	0x358B,	2
asm_instr MOV_DWORD_PTR_BYTE, 	0x05C7,	2
asm_instr FLD_DWORD_PTR,		0x05D9,	2

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

proc VirtualProtect_s ;lpAddress, dwSize, flNewProtect, lpflOldProtect
	;Jumping into VirtualProtect without re-pushing parameters
	;Save original return address
	mov eax, [esp]
	mov [.orig_ret + 1], eax
	sub dword[.orig_ret + 1], .orig_ret + 5
	;Set new return address
	mov dword[esp], .return
	jmp [VirtualProtect]
	.return:
	test eax, eax
	jnz .orig_ret
	stdcall ShowFatalError, szErr_VirtualProtect_s
	.orig_ret:
	jmp near .orig_ret ;force 4byte jmp, (jmp dest is modified above)
endp

proc GetRootDir
	invoke GetModuleFileNameW, [self], rootDir, MAX_PATH
	test eax, eax
	jz FatalError
	
	std
	mov ecx, eax
	shl eax, 1
	mov edi, rootDir
	add edi, eax
	mov ax, '\'
	repne scasw
	cld ;WinAPI hangs if DF=1

	mov word[edi + 2], 0
	ret
endp
