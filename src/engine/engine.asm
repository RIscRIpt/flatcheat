proc pfnHookEvent szName, pfnEvent
	;cinvoke Engine.pfnHookEvent, [szName], [pfnEvent]
	;ret
	jmp [Engine.pfnHookEvent]
endp

proc pfnHookUserMsg szMsgName, pfnUserMsg
	;cinvoke Engine.pfnHookUserMsg, [szMsgName], [pfnUserMsg]
	;ret
	jmp [Engine.pfnHookUserMsg]
endp

proc pfnAddCommand szCmdName, function
	xor eax, eax
	ret
endp

proc pfnRegisterVariable szName, szValue, flags
	cinvoke Engine.pfnGetCvarPointer, [szName]
	test eax, eax
	jnz .ret
	;cinvoke Engine.pfnRegisterVariable, [szName], [szValue], [flags]
	jmp [Engine.pfnRegisterVariable]
	.ret:
	ret
endp

;Engine.pTriApi->WorldToScreen rewritten to SSE4
proc WorldToScreen c world, screen
	mov eax, [world]
	mov ecx, [screen]
	;mov edx, 0x46F6280
	db ASM_INSTR_MOV_EDX_DWORD
	.patch_addr:
	dd 0x46F6280
	
	virtual at ecx
		.point vec2_s
	end virtual
	
	movups xmm0, [eax]

	movss xmm1, [edx + 0x00]
	insertps xmm1, [edx + 0x10], 00010000b
	insertps xmm1, [edx + 0x20], 00100000b
	dpps xmm1, xmm0, 01110001b
	addss xmm1, [edx + 0x30]

	movss xmm2, [edx + 0x04]
	insertps xmm2, [edx + 0x14], 00010000b
	insertps xmm2, [edx + 0x24], 00100000b
	dpps xmm2, xmm0, 01110001b
	addss xmm2, [edx + 0x34]

	movss xmm3, [edx + 0x0C]
	insertps xmm3, [edx + 0x1C], 00010000b
	insertps xmm3, [edx + 0x2C], 00100000b
	dpps xmm3, xmm0, 01110001b
	addss xmm3, [edx + 0x3C]

	xor eax, eax
	pxor xmm0, xmm0
	comiss xmm3, xmm0
	ja .in_front
	ret
	
	.in_front:
	ptest xmm3, xmm3
	jz .onscreen
		rcpss xmm0, xmm3
		mulss xmm1, xmm0
		mulss xmm2, xmm0
	.onscreen:
	movss [.point.x], xmm1
	movss [.point.y], xmm2
	inc eax
	ret
endp
