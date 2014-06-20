proc flatcheat_inject
	stdcall AO_InitWait
	stdcall AO_GetAll
	
	cinvoke Engine.pfnConsolePrint, szWelcomeMessage

	stdcall Hook_List, hookList_ClientDLL
	;stdcall Hook_List, hookList_Engine
	;cinvoke ClientDLL.Initialize, [pEngine], [ClientDLL_Interface_Version]
	;cinvoke ClientDLL.HUD_Init
	;stdcall Restore_List, restoreList_Engine
	
	stdcall RegisterCommands
	stdcall RegisterCvars
	
	stdcall RedirectClientSpeedMultiplierPtr
	
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
	mov [screenCenterX], eax
	mov [screenCenterY], ecx
	ret
endp

proc InitScreenDataLocation
	mov eax, [screenCenterX]
	mov ecx, [screenCenterY]
	mov edx, [screenInfo.iCharHeight]
	
	push dword 0.7
	fld dword[esp]
	fild [screenInfo.iHeight]
	fmulp ST1, ST0
	fistp dword[esp]
	pop ebx
	
	mov [SI_HSpeed_coord.x], eax
	mov [SI_HSpeed_coord.y], ebx
	
	mov [SI_VSpeed_coord.x], eax
	mov [SI_VSpeed_coord.y], ebx
	add [SI_VSpeed_coord.y], edx
	shl edx, 1
	
	mov [SI_Height_coord.x], eax
	mov [SI_Height_coord.y], ebx
	add [SI_Height_coord.y], edx
	;shr edx, 1
	
	ret
endp
