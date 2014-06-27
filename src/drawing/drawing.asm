proc GetStringWidth s
	xor eax, eax
	xor ecx, ecx
	mov edx, [s]
	.loop:
	mov cl, [edx]
	test ecx, ecx
	jz .ret
	add ax, [screenInfo.charWidths + ecx*2]
	inc edx
	jmp .loop
	.ret:
	ret
endp

proc WriteDoublCenter x, y, dat, dst, val
	cinvoke sprintf, [dst], szFmtDouble, double[val]
	stdcall GetStringWidth, [dat]
	shr eax, 1
	sub [x], eax
	cinvoke Engine.pfnDrawConsoleString, [x], [y], [dat]
	ret
endp

proc CalcScreen origin
	mov eax, [origin]
	;mov edx, 0x46F6280
	db ASM_INSTR_MOV_EDX_DWORD
	.patch_addr:
	dd 0x46F6280

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

	pxor xmm0, xmm0
	comiss xmm3, xmm0
	ja .in_front
	clc
	ret
	
	.in_front:
	ptest xmm3, xmm3
	jz .onscreen
		rcpss xmm0, xmm3
		mulss xmm1, xmm0
		mulss xmm2, xmm0
	.onscreen:

	addss xmm1, [flPOne]
	mulss xmm1, [flScreenCenter.x]
	cvtss2si ecx, xmm1
	
	addss xmm2, [flMOne]
	mulss xmm2, [flScreenCenter.y]
	cvtss2si edx, xmm2
	
	mov [screenCoord.x], ecx
	mov [screenCoord.y], edx
	stc
	ret
endp
