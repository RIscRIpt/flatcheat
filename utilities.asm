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

ASM_INSTR_PUSH_DWORD = 0x68
sizeof.ASM_INSTR_PUSH_DWORD = 1

ASM_INSTR_PUSH_BYTE = 0x6A
sizeof.ASM_INSTR_PUSH_BYTE = 1

ASM_INSTR_CALL_DWORD_PTR = 0x15FF
sizeof.ASM_INSTR_CALL_DWORD_PTR = 2