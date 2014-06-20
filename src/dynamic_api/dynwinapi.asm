proc LoadDynamicAPI
	invoke GetModuleHandleA, szKernel32DLL
	test eax, eax
	jz FatalError
	mov [hKernel32], eax
	
	mov ebx, dynapiList
	.next:
	call dword[ebx]
	add ebx, 4
	cmp ebx, dynapiListEnd
	jne .next
	ret
endp

proc LDAPI_GetModuleInformation
	invoke GetProcAddress, [hKernel32], szK32GetModuleInformation
	test eax, eax
	jz .XP
	mov [GetModuleInformation], eax
	ret
	.XP: ;Fuuuuu XP is not be supported anymore!
	invoke GetProcAddress, [hKernel32], szGetModuleInformation
	test eax, eax
	jz FatalError
	mov [GetModuleInformation], eax
	ret
endp
