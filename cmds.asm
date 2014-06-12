proc PatchCmdMallocAddr
	local dwOldProt dd ?
	mov edi, [pRegCmdWFMallocCall]
	mov ebx, [edi]
	mov [RegCmdMallocCallOrig], ebx
	lea ebx, [edi - 1 + 5] ;dest - (src + 5)
	neg ebx
	add ebx, CmdMalloc
	
	;Writing to .code section
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, PAGE_EXECUTE_READWRITE, eax
	mov [edi], ebx
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, [dwOldProt], eax
	ret
endp

proc RestoreCmdMallocAddr
	local dwOldProt dd ?
	mov edi, [pRegCmdWFMallocCall]
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, PAGE_EXECUTE_READWRITE, eax
	mov ecx, [RegCmdMallocCallOrig]
	mov [edi], ecx
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, [dwOldProt], eax
	ret
endp

proc CmdMalloc c size
	mov eax, [cmdMallocResult]
	ret
endp

proc RegisterCommands
	stdcall PatchCmdMallocAddr
	mov esi, cmdList
	virtual at esi
		.cmd command_s
	end virtual
	.next:
	mov [cmdMallocResult], esi	
	cinvoke pRegisterCommandWithFlag, [.cmd.name], [.cmd.func], 0 ;flag 0 = do not Z_Free
	add esi, sizeof.command_s
	cmp esi, cmdListEnd
	jne .next
	stdcall RestoreCmdMallocAddr
	ret
endp
