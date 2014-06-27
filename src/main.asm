proc flatcheat_inject
	stdcall AO_InitWait
	stdcall AO_GetAll
	
	cinvoke Engine.pfnConsolePrint, szWelcomeMessage

	stdcall Hook_List, hookList_ClientDLL
	;stdcall Hook_List, hookList_Engine
	;cinvoke ClientDLL.Initialize, [pEngine], [ClientDLL_Interface_Version]
	;cinvoke ClientDLL.HUD_Init
	;stdcall Restore_List, restoreList_Engine
	
	stdcall Hook_Cvars
	
	stdcall RegisterCommands
	stdcall RegisterCvars
	
	stdcall RedirectClientSpeedMultiplierPtr
	stdcall PatchRefreshFunc
	stdcall PatchWorldToScreen
	chkftr PATCH_CONNECTION_CVARS, <stdcall PatchConnectionCvars>
	chkftr PATCH_SETINFO, <stdcall PatchSetinfo>
	
	stdcall GetScreenInfo
	stdcall InitScreenDataLocation
	ret
endp

proc Hook_List, list
	mov ebx, [list]
	virtual at ebx
		.vt VTHook_s
	end virtual
	.next:
	mov eax, [.vt.table]
	mov eax, [eax]
	add eax, [.vt.table_offset]
	mov edx, [.vt.new_func]
	mov [eax], edx
	add ebx, sizeof.VTHook_s
	cmp dword[ebx], 0
	jne .next
	ret
endp

proc Restore_List, list
	mov ebx, [list]
	virtual at ebx
		.vt VTRestore_s
	end virtual
	.next:
	mov eax, [.vt.table]
	mov eax, [eax]
	mov edx, [.vt.table_orig]
	mov ecx, [.vt.table_offset]
	mov edx, [edx + ecx]
	mov [eax + ecx], edx
	add ebx, sizeof.VTRestore_s
	cmp dword[ebx], 0
	jne .next
	ret
endp

proc Hook_Cvars
	mov ebx, cvarHookList
	virtual at ebx
		.ch CvarHook_s
	end virtual
	.next:
	cinvoke Engine.pfnGetCvarPointer, [.ch.org_name]
	test eax, eax
	jnz .found
	jmpcall ShowFatalError, szErr_FailedToFindCvar_x, [.ch.org_name]
	.found:
	virtual at eax
		.cvar cvar_s
	end virtual
	cmp [.ch.psave], 0
	je .skip_save
		mov ecx, [.ch.psave]
		lea edx, [.cvar.value]
		mov [ecx], edx
	.skip_save:
	;Replace name
	mov ecx, [.ch.new_name]
	mov [.cvar.name], ecx
	;Create fake cvar with original name
	cinvoke Engine.pfnRegisterVariable, [.ch.org_name], [.cvar..string], 0
	add ebx, sizeof.CvarHook_s
	cmp dword[ebx], 0
	jne .next
	ret
endp

proc RedirectClientSpeedMultiplierPtr
	;There should be 30 redirections in total
	;Plus one more check to ensure that no more redirections are needed
	local counter dd 30 + 1
	local result dd ?
	local oldprot dd ?
	local searchbase dd ?
	local searchsize dd ?
	
	mov eax, [hw.base]
	mov ecx, [hw.size]
	mov [searchbase], eax
	mov [searchsize], ecx
	
	.loop:
	stdcall FindBytePattern, [searchbase], [searchsize], pClientSpeed, 4
	test eax, eax
	jz .not_found		
		mov [result], eax
		lea ecx, [oldprot]
		stdcall VirtualProtect_s, eax, 4, PAGE_EXECUTE_READWRITE, ecx
		mov eax, [result]
		mov dword[eax], clientSpeed
		lea ecx, [oldprot]
		stdcall VirtualProtect_s, eax, 4, [oldprot], ecx
		
		mov eax, [result]
		add eax, 4
		mov [searchbase], eax
		sub eax, [hw.base]
		sub [searchsize], eax
		
		dec [counter]
		js .fail ;if counter < 0, jmp .fail
		jmp .loop
	.not_found:
		dec [counter]
		jz .ok
		.fail:
		jmpcall ShowFatalError, szErr_RedirectClientSpeedMultiplierPtr
	.ok:
	ret
endp

proc GetScreenInfo
	cinvoke Engine.pfnGetScreenInfo, screenInfo
	mov eax, [screenInfo.iWidth]
	mov ecx, [screenInfo.iHeight]
	shr eax, 1
	shr ecx, 1
	cvtsi2ss xmm0, eax
	cvtsi2ss xmm1, ecx
	movss [flScreenCenter.x], xmm0
	movss [flScreenCenter.y], xmm1
	bts [flScreenCenter.y], 31 ;make value negative (required for CalcScreen)
	ret
endp

proc InitScreenDataLocation
	mov edx, [screenInfo.iCharHeight]
	
	push dword SI_KZ_LOCATION_X	
	push dword SI_KZ_LOCATION_Y
	fld dword[esp]
	fld dword[esp + 4]
	fimul [screenInfo.iWidth]
	fistp dword[esp + 4]
	fimul [screenInfo.iHeight]
	fistp dword[esp]
	pop ebx
	pop eax
	
	mov [SI_KZ_HSpeed_coord.x], eax
	mov [SI_KZ_HSpeed_coord.y], ebx
	add ebx, edx
	
	mov [SI_KZ_VSpeed_coord.x], eax
	mov [SI_KZ_VSpeed_coord.y], ebx
	add ebx, edx
	
	mov [SI_KZ_Height_coord.x], eax
	mov [SI_KZ_Height_coord.y], ebx
	;add ebx, edx
	
	ret
endp

; New, patched CPU Disasm
; Address   Hex dump                    Command                            Comments
; 038752E0      833D E0528703 00        CMP DWORD PTR DS:[hw.38752E0],0    ; hw.038752E0(guessed void)
; 038752E7      75 41                   JNE SHORT hw.0387532A
; 038752E9      55                      PUSH EBP
; 038752EA      89E5                    MOV EBP,ESP
; 038752EC      83EC 14                 SUB ESP,14
; 038752EF      C705 C0626F04 00000000  MOV DWORD PTR DS:[hw.46F62C0],0
; 038752F9      E8 B2F8FFFF             CALL hw.03874BB0                   ; original can be found at [$ + 0x7C]
; 038752FE      A1 6C626F04             MOV EAX,DWORD PTR DS:[hw.46F626C]
; 03875303      85C0                    TEST EAX,EAX
; 03875305      75 05                   JNE SHORT hw.0387530C
; 03875307      E8 24EAFFFF             CALL hw.03873D30                   ; original can be found at [$ + 0x8A]
; 0387530C      E8 DFFEFFFF             CALL hw.038751F0                   ; original can be found at [$ + 0x8F]
; 03875311      A1 6C626F04             MOV EAX,DWORD PTR DS:[hw.46F626C]
; 03875316      85C0                    TEST EAX,EAX
; 03875318      75 0A                   JNE SHORT hw.03875324
; 0387531A      E8 71E6FFFF             CALL hw.03873990                   ; original can be found at [$ + 0x9D]
; 0387531F      E8 CCEBFFFF             CALL hw.03873EF0                   ; original can be found at [$ + 0xA2]
; 03875324      E8 375F0400             CALL hw.038BB260                   ; original can be found at [$ + 0xA7]
; 03875329      C9                      LEAVE
; 0387532A      C3                      RETN
proc PatchRefreshFunc
	local oldprot dd ?
	mov esi, refreshFuncPatch
	mov edi, [pRefreshFunc]
	add edi, 4
	xor ecx, ecx
	.pof_loop:
		movzx ebx, [refreshFuncPatchOrigFunc + ecx]
		test ebx, ebx
		jz .patchedOrigFunc
		add esi, ebx
		add edi, ebx
		mov edx, [pRefreshFuncOrigCalls + ecx * 4]
		sub edx, edi
		mov dword[esi], edx
		inc ecx
		jmp .pof_loop
	.patchedOrigFunc:
	
	mov dword[refreshFuncPatch + 2], r_norefresh.value
	mov eax, [pRefreshFuncOrigAddrs + 0*4]
	mov ecx, [pRefreshFuncOrigAddrs + 1*4]
	mov dword[refreshFuncPatch + 17], eax
	mov dword[refreshFuncPatch + 31], ecx
	mov dword[refreshFuncPatch + 50], ecx
	
	lea eax, [oldprot]
	stdcall VirtualProtect_s, edi, sizeof.refreshFuncPatch, PAGE_EXECUTE_READWRITE, eax
	mov esi, refreshFuncPatch
	mov edi, [pRefreshFunc]
	mov ecx, sizeof.refreshFuncPatch / 4
	rep movsd
	lea eax, [oldprot]
	stdcall VirtualProtect_s, [pRefreshFunc], sizeof.refreshFuncPatch, [oldprot], eax
	
	ret
endp

proc PatchConnectionCvars
feature PATCH_CONNECTION_CVARS
	local oldprot dd ?
	stdcall FindRefCallAddr, [hw.base], [hw.size], [pLimitConnectionCvarsFunc]
	test eax, eax
	jnz .found
	jmpcall ShowFatalError, szErr_FailToFindLimConnCvarsFuncRef
	.found:
	mov edi, eax
	lea eax, [oldprot]
	stdcall VirtualProtect_s, edi, 5, PAGE_EXECUTE_READWRITE, eax
	;Patch with 5byte NOP
	mov byte[edi], 0x66
	mov dword[edi + 1], 0x90666666
	lea eax, [oldprot]
	stdcall VirtualProtect_s, edi, sizeof.refreshFuncPatch, [oldprot], eax
endf
	ret
endp

proc PatchSetinfo
feature PATCH_SETINFO
	local oldprot dd ?
	mov edi, [pSetinfoJmpPatchPlace]
	lea eax, [oldprot]
	stdcall VirtualProtect_s, edi, 1, PAGE_EXECUTE_READWRITE, eax
	mov byte[edi], ASM_INSTR_JMP_SHORT
	lea eax, [oldprot]
	stdcall VirtualProtect_s, edi, 1, [oldprot], eax
endf
	ret
endp

proc PatchWorldToScreen
	local oldprot dd ?
	local base dd ?
	local sizeleft dd ?
	
	mov eax, [pViewMatrix]
	mov [WorldToScreen.patch_addr], eax
	mov [CalcScreen.patch_addr], eax
	
	;Redirect all WorldToScreen calls to our SSE4 version
	mov ecx, [hw.size]
	mov edi, [hw.base]
	mov [sizeleft], ecx
	mov [base], edi
	.loop:
		stdcall FindRefCallAddr, [base], [sizeleft], [pWorldToScreen]
		test eax, eax
		jz .done
		mov [sizeleft], ecx ;FindRefCallAddr uses ecx only for scasb
		lea edi, [eax + 1]
		lea ebx, [oldprot]
		stdcall VirtualProtect_s, edi, 4, PAGE_EXECUTE_READWRITE, ebx
		mov dword[edi], WorldToScreen - 4
		sub dword[edi], edi
		lea ebx, [oldprot]
		stdcall VirtualProtect_s, edi, 4, [oldprot], ebx
		add edi, 4
		sub [sizeleft], 4
		mov [base], edi
		jmp .loop
	.done:
	ret
endp
