proc flatcheat_inject
	stdcall LoadPrefix
	
	stdcall AO_InitWait
	stdcall AO_GetAll
	
	cinvoke Engine.pfnConsolePrint, szWelcomeMessage

	stdcall Hook_List, hookList_ClientDLL
	;stdcall Hook_List, hookList_Engine
	;cinvoke ClientDLL.Initialize, [pEngine], [ClientDLL_Interface_Version]
	;cinvoke ClientDLL.HUD_Init
	;stdcall Restore_List, restoreList_Engine
	
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

proc LoadPrefix
	invoke CreateFile, szPrefixFilename, GENERIC_READ, 0, 0, OPEN_EXISTING, 0, 0
	cmp eax, INVALID_HANDLE_VALUE
	je .fail ;just ignore the error, default prefix will be used instead.
	mov esi, eax
	invoke ReadFile, esi, prefix, sizeof.prefix - 1, 0, 0
	mov edi, eax
	invoke CloseHandle, esi
	test edi, edi
	jz FatalError
	.fail:
	ret
endp
