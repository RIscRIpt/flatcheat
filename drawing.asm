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
	cinvoke gcvt, double[val], SCREEN_INFO_FLOAT_DIGITS, [dst]
	stdcall GetStringWidth, [dat]
	shr eax, 1
	sub [x], eax
	cinvoke Engine.pfnDrawConsoleString, [x], [y], [dat]
	ret
endp
