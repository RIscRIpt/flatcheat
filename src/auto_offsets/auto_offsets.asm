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

; Original CPU Disasm
; Address   Hex dump             Command                                       Comments
; 038752E0  /$  55               PUSH EBP                                      ; hw.038752E0(guessed void)
; 038752E1  |.  8BEC             MOV EBP,ESP
; 038752E3  |.  83EC 14          SUB ESP,14
; 038752E6  |.  D905 90419703    FLD DWORD PTR DS:[hw.3974190]                 ; FLOAT 0.0  [r_norefresh.value]
; 038752EC  |.  D81D 48B09403    FCOMP DWORD PTR DS:[hw.394B048]               ; FLOAT 0.0  [floatZero]
; 038752F2  |.  DFE0             FSTSW AX
; 038752F4  |.  F6C4 44          TEST AH,44
; 038752F7  |.  0F8A 11010000    JPE hw.0387540E                               ; Taken if ST(0)<[394B048] or operands are unordered in preceding FCOMP at 038752EC
proc AO_GetRefreshFunc
	cinvoke Engine.pfnGetCvarPointer, szr_norefresh
	test eax, eax
	jnz .found1
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetRefreshFunc, szLocation, szr_norefresh
	.found1:
	add eax, cvar_s.value
	mov dword[bpClearFunction + 8], eax
	stdcall FindBytePattern, [hw.base], [hw.size], bpClearFunction, sizeof.bpClearFunction - 1
	test eax, eax
	jnz .found2
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetRefreshFunc, szReference, szr_norefresh
	.found2:
	mov [pRefreshFunc], eax
	ret
endp

proc AO_GetRefreshFuncOrigAddessess
	mov eax, [pRefreshFunc]
	xor ecx, ecx
	.loop1:
		movzx ebx, [offOrigClearFunctions + ecx]
		test ebx, ebx
		jz .done1
		add eax, ebx
		cmp byte[eax], ASM_INSTR_CALL
		je .found1
		jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
			szAO_GetRefreshFuncOrigAddessess, szByte, [eax], eax, ASM_INSTR_CALL
		.found1:
		mov edx, [eax + 1]
		lea edx, [edx + eax + 5]
		mov [pRefreshFuncOrigCalls + ecx*4], edx
		inc ecx
		jmp .loop1
	.done1:
	mov eax, [pRefreshFunc]
	add eax, 0x71
	cmp word[eax], ASM_INSTR_MOV_DWORD_PTR_BYTE
	je .found2
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRefreshFuncOrigAddessess, szWord, [eax], eax, ASM_INSTR_MOV_DWORD_PTR_BYTE
	.found2:
	mov ecx, [eax + 2]
	mov [pRefreshFuncOrigAddrs + 0*4], ecx
	add eax, 0x22
	cmp byte[eax], ASM_INSTR_MOV_EAX_DWORD_PTR
	je .found3
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetRefreshFuncOrigAddessess, szByte, [eax], eax, ASM_INSTR_MOV_EAX_DWORD_PTR
	.found3:
	mov ecx, [eax + 1]
	mov [pRefreshFuncOrigAddrs + 1*4], ecx
	ret
endp

proc AO_GetFuncLimitConnectionCvars
	stdcall FindBytePattern, [hw.base], [hw.size], szcl_updatereate_min, sizeof.szcl_updatereate_min - 1
	test eax, eax
	jnz .found1
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetFuncLimitConnectionCvars, szLocation, szcl_updatereate_min
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetFuncLimitConnectionCvars, szReference, szcl_updatereate_min
	.found2:
	sub eax, 0x3A
	cmp byte[eax], ASM_INSTR_PUSH_EBP
	je .found3
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetFuncLimitConnectionCvars, szByte, [eax], eax, ASM_INSTR_PUSH_EBP
	.found3:
	mov [pLimitConnectionCvarsFunc], eax
	ret
endp

proc AO_GetSetinfoJmpPatchPlace
	stdcall FindBytePattern, [hw.base], [hw.size], szCantSetStarKeys, sizeof.szCantSetStarKeys - 1
	test eax, eax
	jnz .found1
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetSetinfoJmpPatchPlace, szLocation, szCantSetStarKeys
	.found1:
	FindRefWithPrefix [hw.base], [hw.size], ASM_INSTR_PUSH_DWORD, sizeof.ASM_INSTR_PUSH_DWORD, eax
	test eax, eax
	jnz .found2
	jmpcall ShowFatalError, szErr_s_FailedToFindXOf_s,\
		szAO_GetSetinfoJmpPatchPlace, szReference, szCantSetStarKeys
	.found2:
	sub eax, 2
	cmp byte[eax], ASM_INSTR_JNE
	je .found3
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetSetinfoJmpPatchPlace, szByte, [eax], eax, ASM_INSTR_JNE
	.found3:
	mov [pSetinfoJmpPatchPlace], eax
	ret
endp

proc AO_GetWorldToScreenViewMatrix
	mov eax, [Engine.pTriAPI]
	mov eax, [eax + triangleapi_s.WorldToScreen]
	add eax, 0x0B
	cmp byte[eax], ASM_INSTR_CALL
	je .found1
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetWorldToScreenViewMatrix, szByte, [eax], eax, ASM_INSTR_CALL
	.found1:
	add eax, [eax + 1]
	add eax, 5
	mov [pWorldToScreen], eax
	add eax, 0x0A
	cmp word[eax], ASM_INSTR_FLD_DWORD_PTR
	je .found2
	jmpcall ShowFatalError, szErr_s_Failed_Invalid_x_at_x_x,\
		szAO_GetWorldToScreenViewMatrix, szWord, [eax], eax, ASM_INSTR_FLD_DWORD_PTR
	.found2:
	mov eax, [eax + 2]
	mov [pViewMatrix], eax
	ret
endp
