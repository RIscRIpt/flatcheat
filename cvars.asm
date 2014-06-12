proc PatchCvarMallocAddr
	local dwOldProt dd ?
	mov edi, [pRegVarMallocCall]
	mov ebx, [edi]
	mov [RegVarMallocCallOrig], ebx
	lea ebx, [edi - 1 + 5] ;dest - (src + 5)
	neg ebx
	add ebx, CvarMalloc
	
	;Writing to .code section
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, PAGE_EXECUTE_READWRITE, eax
	mov [edi], ebx
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, [dwOldProt], eax
	ret
endp

proc RestoreCvarMallocAddr
	local dwOldProt dd ?
	mov edi, [pRegVarMallocCall]
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, PAGE_EXECUTE_READWRITE, eax
	mov ecx, [RegVarMallocCallOrig]
	mov [edi], ecx
	lea eax, [dwOldProt]
	stdcall VirtualProtect_s, edi, 4, [dwOldProt], eax
	ret
endp

proc CvarMalloc c size
	mov eax, [cvarMallocResult]
	ret
endp

proc RegisterCvars
	stdcall PatchCvarMallocAddr
	mov esi, cvarList ;using esi, because it is preserved by pfnRegisterVariable
	virtual at esi
		.cvar cvar_s
	end virtual
	.next:
	mov [cvarMallocResult], esi	
	cinvoke Engine.pfnRegisterVariable, [.cvar.name], [.cvar.def_val], 0
	;disable flag to Z_Free this memory, otherwise following error will occur:
	;"Z_Free: freed a pointer without ZONEID"
	and [.cvar.flags], not 0x10 
	add esi, sizeof.cvar_s
	cmp esi, cvarListEnd
	jne .next
	stdcall RestoreCvarMallocAddr
	ret
endp
