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
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetScreenFadePushReference, szLocation, szScreenFade
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetScreenFadePushReference, szReference, szScreenFade
	.found2:
	mov [pushScreenFade], eax
	ret
endp

proc AO_GetEngine
	mov eax, [pushScreenFade]
	add eax, 0x0C
	cmp byte[eax], ASM_INSTR_PUSH_DWORD
	je .found
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetEngine, szByte, [eax], eax, ASM_INSTR_PUSH_DWORD
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
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetClientDLL, szWord, [eax], eax, ASM_INSTR_CALL_DWORD_PTR
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
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetPlayerMove_Ptr, szByte, [eax], eax, ASM_INSTR_PUSH_DWORD
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
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetClientDLL_Interface_Version, szReference, szClientDLLInitialize
	.found1:
	sub eax, 7
	cmp byte[eax], ASM_INSTR_PUSH_BYTE
	je .ver_is_byte
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetClientDLL_Interface_Version, szByte, [eax], eax, ASM_INSTR_PUSH_BYTE
	.ver_is_byte:
	mov al, [eax + 1]
	mov byte[ClientDLL_Interface_Version], al
	ret
endp

proc AO_GetClientSpeedMultiplier
	stdcall FindBytePattern, [hw.base], [hw.size], szTextureLoadMs, sizeof.szTextureLoadMs - 1
	test eax, eax
	jnz .found1
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetClientSpeedMultiplier, szLocation, szTextureLoadMs
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetClientSpeedMultiplier, szReference, szTextureLoadMs
	.found2:
	sub eax, 7
	mov eax, [eax]
	mov [pClientSpeed], eax
	ret
endp

proc AO_GetPushHGSMIReference
	stdcall FindBytePattern, [hw.base], [hw.size], szErrMsgCouldntGetStudioModelRI, sizeof.szErrMsgCouldntGetStudioModelRI - 1
	test eax, eax
	jnz .found1
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetPushHGSMIReference, szLocation, szErrMsgCouldntGetStudioModelRI
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetPushHGSMIReference, szReference, szErrMsgCouldntGetStudioModelRI
	.found2:
	mov [pushErrMsgClDLLStudioRI], eax
	ret
endp

proc AO_GetEngineStudio
	mov eax, [pushErrMsgClDLLStudioRI]
	cmp byte[eax - 0x15], ASM_INSTR_PUSH_DWORD
	je .found
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetEngineStudio, szByte, [eax], eax, ASM_INSTR_PUSH_DWORD
	.found:
	mov eax, [eax - 0x14]
	mov [pEngineStudio], eax
	ret
endp

proc AO_GetStudioModelInterface
	mov eax, [pushErrMsgClDLLStudioRI]
	cmp byte[eax - 0x10], ASM_INSTR_PUSH_DWORD
	je .found
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetStudioModelInterface, szByte, [eax], eax, ASM_INSTR_PUSH_DWORD
	.found:
	mov eax, [eax - 0x0F]
	mov [pStudioInterface], eax
	ret
endp

proc AO_GetConsoleColor
	stdcall GetCmdByNameL, szClear, sizeof.szClear
	test eax, eax
	jnz .found1
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetConsoleColor, szReference, szClear
	.found1:
	mov eax, [eax + command_s.func]
	add eax, 0x19
	cmp byte[eax], ASM_INSTR_JMP
	je .found2
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetConsoleColor, szByte, [eax], eax, ASM_INSTR_JMP
	.found2:
	lea edx, [eax + 1 + 4]
	mov eax, [eax + 1]
	add eax, edx
	cmp word[eax], ASM_INSTR_MOV_ECX_DWORD_PTR
	je .found3
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetConsoleColor, szWord, [eax], eax, ASM_INSTR_MOV_ECX_DWORD_PTR
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

proc AO_GetRegisterVariableMallocCall
	mov eax, [Engine.pfnRegisterVariable]
	add eax, 0x16
	cmp byte[eax], ASM_INSTR_PUSH_BYTE
	je .found1
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegisterVariableMallocCall, szByte, [eax], eax, ASM_INSTR_PUSH_BYTE
	.found1:
	cmp byte[eax + 1], sizeof.cvar_s - 4 ;def_val should not be in cvar_s
	je .found2
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegisterVariableMallocCall, szByte, [eax], eax, sizeof.cvar_s - 4
	.found2:
	cmp byte[eax + 2], ASM_INSTR_CALL
	je .found3
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegisterVariableMallocCall, szByte, [eax], eax, ASM_INSTR_CALL
	.found3:
	add eax, 3
	mov [pRegVarMallocCall], eax
	ret
endp

proc AO_GetRegisterCommandWithFlag
	mov eax, [Engine.pfnAddCommand]
	add eax, 0x19
	cmp byte[eax], ASM_INSTR_CALL
	je .found1
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegisterCommandWithFlag, szByte, [eax], eax, ASM_INSTR_CALL
	.found1: ;RegisterCommand with flag 1 (free memory on exit)
	add eax, [eax + 1]
	add eax, 5 + 0x0D
	cmp byte[eax], ASM_INSTR_CALL
	je .found2
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegisterCommandWithFlag, szByte, [eax], eax, ASM_INSTR_CALL
	.found2:
	add eax, [eax + 1]
	add eax, 5
	mov [pRegisterCommandWithFlag], eax
	ret
endp

proc AO_GetRegCmdWithFlagMallocCall
	mov eax, [pRegisterCommandWithFlag]
	add eax, 0x4A
	cmp byte[eax], ASM_INSTR_PUSH_BYTE
	je .found1
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegCmdWithFlagMallocCall, szByte, [eax], eax, ASM_INSTR_PUSH_BYTE
	.found1:
	cmp byte[eax + 1], sizeof.command_s
	je .found2
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegCmdWithFlagMallocCall, szByte, [eax], eax, sizeof.command_s
	.found2:
	cmp byte[eax + 2], ASM_INSTR_CALL
	je .found3
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRegCmdWithFlagMallocCall, szByte, [eax], eax, ASM_INSTR_CALL
	.found3:
	add eax, 3
	mov [pRegCmdWFMallocCall], eax
	ret
endp
