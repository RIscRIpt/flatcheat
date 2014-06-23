;must be called in CL_CreateMove, esi = cmd, edi = pmove
proc GetDistanceToGround
	push ebp
	mov ebp, esp
	and esp, not 15
	sub esp, 16
	
	virtual at edi
		.pmove playermove_s
	end virtual
	
	virtual at esp
		.tmp vec4_s
	end virtual
	
	test [.pmove.flags], FL_ONGROUND
	jz .not_on_ground
	xorps xmm0, xmm0
	jmp .ret	
	
	.not_on_ground:
	movups xmm0, [.pmove.origin]
	movups [.tmp], xmm0
	
	lea eax, [.pmove.origin]
	lea edx, [.tmp]
	
	mov [.tmp.z], -4096.0
	
	cinvoke Engine.PM_TraceLine, eax, edx, 1, 0, -1
	
	movss xmm0, [.tmp.z]
	subss xmm0, [.pmove.origin.z]
	mulss xmm0, [eax + pmtrace_s.fraction]
	cvtss2sd xmm0, xmm0
	.ret:
	movlpd [me.distance_to_ground], xmm0
	btr dword[me.distance_to_ground + 4], 31 ;absolute value
	leave
	ret
endp

;must be called in CL_CreateMove, esi = cmd, edi = pmove
proc GetPlayerSpeed
	virtual at edi
		.pmove playermove_s
	end virtual
	movss xmm0, [.pmove.velocity.x]
	mulss xmm0, xmm0
	
	movss xmm1, [.pmove.velocity.y]
	mulss xmm1, xmm1
	
	addss xmm0, xmm1
	sqrtss xmm0, xmm0

	cvtss2sd xmm0, xmm0
	movlpd [me.horizontal_speed], xmm0
	
	movss xmm0, [.pmove.velocity.z]
	cvtss2sd xmm0, xmm0
	movlpd [me.vertical_speed], xmm0
	btr dword[me.vertical_speed + 4], 31 ;absolute value
	ret
endp
