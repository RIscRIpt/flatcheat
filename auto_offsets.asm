proc AO_InitWait
	local sleepTime dd 0
	
	mov esi, moduleList
	
	.loop:
	invoke Sleep, [sleepTime]
	inc [sleepTime]
	
	.next:
	stdcall AO_ParseModule
	test eax, eax
	jz .loop
	
	add esi, sizeof.hl_module
	cmp esi, moduleListEnd
	jne .next
		
	ret
endp

proc AO_ParseModule ;hl_module param at esi
	virtual at esi
		.m hl_module
	end virtual
	
	invoke GetModuleHandleA, [.m.name]
	test eax, eax
	jz .fail

	locals
		mi MODULEINFO
	endl
	
	lea ecx, [mi]
	invoke GetModuleInformation, [hlexe], eax, ecx, sizeof.MODULEINFO
	test eax, eax
	jz .fail
	
	mov eax, [mi.lpBaseOfDll]
	mov ecx, [mi.SizeOfImage]
	mov [.m.base], eax
	mov [.m.size], ecx
	
	.fail: ;if fail, eax = 0, otherwise eax=lpBaseOfDll
	ret
endp

proc AO_GetAll uses ebp ;ebp is the only register that is saved between calls of AO_??? because of FindBytePattern
	mov ebp, ao_getList
	.next:
	call dword[ebp]
	add ebp, 4
	cmp ebp, ao_getListEnd
	jne .next
	ret
endp

proc AO_GetEngine
	stdcall FindBytePattern, [hw.base], [hw.size], szScreenFade, sizeof.szScreenFade - 1
	test eax, eax
	jnz .found1
	stdcall ShowFatalError, szErr_GetEngine_screenfade
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	stdcall ShowFatalError, szErr_GetEngine_ref
	.found2:
	add eax, 0x0D
	mov eax, [eax]
	mov [pEngine], eax
	memcpy Engine, eax, sizeof.Engine_s
	ret
endp

proc AO_GetClientDLL
	stdcall FindBytePattern, [hw.base], [hw.size], szScreenFade, sizeof.szScreenFade - 1
	test eax, eax
	jnz .found1
	stdcall ShowFatalError, szErr_GetClientDLL_screenfade
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	stdcall ShowFatalError, szErr_GetClientDLL_ref
	.found2:
	add eax, 0x13
	mov eax, [eax]
	mov [pClientDLL], eax
	memcpy ClientDLL, eax, sizeof.ClientDLL_s
	ret
endp

proc AO_GetClientDLL_Interface_Version
	mov eax, [pClientDLL]
	if ~ ClientDLL_s.Initialize = 0
		add eax, ClientDLL_s.Initialize ;Initialize should be 0
	end if
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_CALL_DWORD_PTR, sizeof.ASM_INSTR_CALL_DWORD_PTR, eax
	test eax, eax
	jnz .found1
	stdcall ShowFatalError, szErr_GetClientDLL_IV_ref
	.found1:
	sub eax, 7
	cmp byte[eax], ASM_INSTR_PUSH_BYTE
	je .ver_is_byte
	stdcall ShowFatalError, szErr_GetClientDLL_IV_notbyte
	.ver_is_byte:
	mov al, [eax + 1]
	mov byte[ClientDLL_Interface_Version], al
	ret
endp

proc AO_GetConsoleColor
	;DWORD dwConColor = (*(DWORD*)(((**(DWORD**)((((DWORD)FindCmd("clear") + 26) + (*(DWORD*)((DWORD)FindCmd("clear") + 26)) + 4) + 2)) + 8)) + 296 );  // This is my version of it with 2xFindCmd
	;pConColor = (color24*)dwConColor;
	;pConColorDev = (color24*)(dwConColor + 4);
	ret
endp
