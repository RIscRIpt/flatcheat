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

proc AO_GetScreenFadePushReference
	stdcall FindBytePattern, [hw.base], [hw.size], szScreenFade, sizeof.szScreenFade - 1
	test eax, eax
	jnz .found1
	stdcall ShowFatalError, szErr_GetScreenFadePushReference1
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	stdcall ShowFatalError, szErr_GetScreenFadePushReference2
	.found2:
	mov [pushScreenFade], eax
	ret
endp

proc AO_GetEngine
	mov eax, [pushScreenFade]
	add eax, 0x0C
	cmp byte[eax], ASM_INSTR_PUSH_DWORD
	je .found
	stdcall ShowFatalError, szErr_GetEngine_InvalidByte
	.found:
	mov eax, [eax + 1]
	mov [pEngine], eax
	memcpy Engine, eax, sizeof.Engine_s
	ret
endp

proc AO_GetClientDLL
	mov eax, [pushScreenFade]
	add eax, 0x11
	cmp word[eax], ASM_INSTR_CALL_DWORD_PTR
	je .found
	stdcall ShowFatalError, szErr_GetClientDLL_InvalidWord
	.found:
	mov eax, [eax + 2]
	mov [pClientDLL], eax
	memcpy ClientDLL, eax, sizeof.ClientDLL_s
	ret
endp

proc AO_GetPlayerMove_Ptr
	mov eax, [pushScreenFade]
	add eax, 0x17
	cmp byte[eax], ASM_INSTR_PUSH_DWORD
	je .found
	stdcall ShowFatalError, szErr_GetPlayerMove_Ptr_IB
	.found:
	mov eax, [eax + 1]
	mov [me.ppmove], eax
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
	stdcall GetCmdByNameL, szClear, sizeof.szClear
	test eax, eax
	jnz .found1
	stdcall ShowFatalError, szErr_GetConsoleColor_CmdClear
	.found1:
	mov eax, [eax + command_s.func]
	add eax, 0x19
	cmp byte[eax], ASM_INSTR_JMP
	je .found2
	stdcall ShowFatalError, szErr_GetConsoleColor_IB
	.found2:
	lea edx, [eax + 1 + 4]
	mov eax, [eax + 1]
	add eax, edx
	cmp word[eax], ASM_INSTR_MOV_ECX_DWORD_PTR
	je .found3
	stdcall ShowFatalError, szErr_GetConsoleColor_IW
	.found3:
	mov eax, [eax + 2]
	mov eax, [eax]
	mov eax, [eax + 8]
	add eax, 0x128
	mov [pConsoleColor], eax
	add eax, 4
	mov [pConsoleDevColor], eax
	ret
endp
