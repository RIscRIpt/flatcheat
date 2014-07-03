proc LoadDynamicAPI
	mov ebx, dynapiList
	.next:
	call dword[ebx]
	add ebx, 4
	cmp ebx, dynapiListEnd
	jne .next
	ret
endp

proc _DAPI_CheckDLL ;edi - dest, edx - string
	invoke GetModuleHandleA, edx
	test eax, eax
	jz .error
	mov [edi], eax
	ret
	.error:
	test esi, esi
	jz FatalError
	ret
endp

macro DAPI_CheckDLL dest, s, fail_on_error {
	mov edi, dest
	mov edx, s
	if fail_on_error
		xor esi, esi
	else
		mov esi, 1
	end if
	stdcall _DAPI_CheckDLL
}

proc LDAPI_GetModuleInformation
	DAPI_CheckDLL hKernel32, szKernel32DLL, 1
	invoke GetProcAddress, [hKernel32], szK32GetModuleInformation
	test eax, eax
	jz .XP
	mov [GetModuleInformation], eax
	ret
	.XP: ;Fuuuuu XP is not be supported anymore!
	DAPI_CheckDLL hPSAPI, szPsAPIDLL, 1
	invoke GetProcAddress, [hPSAPI], szGetModuleInformation
	test eax, eax
	jz FatalError
	mov [GetModuleInformation], eax
	ret
endp
