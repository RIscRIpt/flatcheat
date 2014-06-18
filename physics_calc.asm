;must be called in CL_CreateMove, esi = cmd, edi = pmove
proc GetDistanceToGround
	local tmp vec3_s ?
	local dump dd ? ;vec3_s is 3 dwords length, xmm uses 4 dwords

	virtual at edi
		.pmove playermove_s
	end virtual
	
	test [.pmove.flags], FL_ONGROUND
	jz .not_on_ground
	
	fldz
	jmp .ret	
	
	.not_on_ground:
	movups xmm0, [.pmove.origin]
	movups [tmp], xmm0
	
	lea eax, [.pmove.origin]
	lea edx, [tmp]
	
	mov [tmp.z], -4096.0
	
	cinvoke Engine.PM_TraceLine, eax, edx, 1, 0, -1
	
	fld [eax + pmtrace_s.fraction]
	fld [tmp.z]
	fsub [.pmove.origin.z]
	fmulp ST1, ST0
	fchs
	.ret:
	fstp [me.distance_to_ground]
	ret
endp

;must be called in CL_CreateMove, esi = cmd, edi = pmove
proc GetPlayerSpeed
	virtual at edi
		.pmove playermove_s
	end virtual
	fld [.pmove.velocity.x]
	fmul [.pmove.velocity.x]

	fld [.pmove.velocity.y]
	fmul [.pmove.velocity.y]

	faddp ST1, ST0
	fsqrt
	fstp [me.horizontal_speed]
	
	fld [.pmove.velocity.z]
	fabs
	fstp [me.vertical_speed]
	ret
endp
