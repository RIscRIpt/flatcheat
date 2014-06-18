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
