proc flatcheat_inject
	stdcall AO_InitWait
	stdcall AO_GetAll
	
	cinvoke Engine.pfnConsolePrint, szWelcomeMessage

	stdcall Hook_List, hookList_ClientDLL
	;stdcall Hook_List, hookList_Engine
	;cinvoke ClientDLL.Initialize, [pEngine], [ClientDLL_Interface_Version]
	;cinvoke ClientDLL.HUD_Init
	;stdcall Restore_List, restoreList_Engine
	
	;stdcall RegisterCommands
	stdcall RegisterCvars
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
