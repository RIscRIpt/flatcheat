;proc HUD_PlayerMove c ppmove, server
;	cinvoke ClientDLL.HUD_PlayerMove, [ppmove], [server]
;	;push eax
;	
;	mov ecx, [ppmove]
;	mov [me.ppmove], ecx
;	
;	;pop eax
;	ret
;endp

proc GetDistanceToGround
	local tmp vec3_s ?
	push edi
	push esi
	
	lea eax, [pmove.origin]
	lea edx, [tmp]
	
	mov ecx, 3
	mov edi, edx
	mov esi, eax
	rep movsd
	
	mov [tmp.z], -4096.0
	
	cinvoke Engine.PM_TraceLine, eax, edx, 1, 0, -1
	
	pop esi
	pop edi
	virtual at edi
		pmove playermove_s
	end virtual
	
	fld [eax + pmtrace_s.fraction]
	fld [tmp.z]
	fsub [pmove.origin.z]
	fmulp ST1, ST0
	fchs
	fstp [me.distance_to_ground]
	ret
endp

;cmd equ esi ;according to debugged info:
;8D3495 682B9C04      LEA ESI,[EDX*4+hw.49C2B68] | ESI = 049C32D4 (var)
;in CL_CreateMove 2nd arg (esp + 8) = 049C32D4 (var)
;=> ESI = cmd (usercmd_s)
proc CL_CreateMove c frametime, cmd, active
	fld [speed.value]
	fstp [clientSpeed]
	
	cinvoke ClientDLL.CL_CreateMove, [frametime], [cmd], [active]
	mov [oCL_CreateMove_result], eax
	
	mov edi, [me.ppmove]
	virtual at edi
		.pmove playermove_s
	end virtual
	
	virtual at esi
		.cmd usercmd_s
	end virtual
	
	feature BHOP
		cmp [bhop.value], 0.0
		je .end_BHOP
			test [.cmd.buttons], IN_JUMP
			jz .end_BHOP
				feature BHOP_STANDUP
					cmp [bhop_standup.value], 0.0
					je .end_BHOP_STANDUP
						fld [bhop_standup_fallingspeed.value]
						fld [.pmove.flFallVelocity]
						fcomip ST1
						fstp ST0
						jbe .end_BHOP_STANDUP
							or [.cmd.buttons], IN_DUCK
				endf
				test [.pmove.flags], FL_ONGROUND
				jnz .end_BHOP
					cmp [.pmove.movetype], MOVETYPE_FLY
					je .end_BHOP
						cmp [.pmove.waterlevel], 2
						jge .end_BHOP
							and [.cmd.buttons], not IN_JUMP
	endf
	
	feature JUMPBUG
		bt [userButtons], UB_JUMPBUG
		jnc .end_JUMPBUG
			cmp [.pmove.movetype], MOVETYPE_FLY
			je .end_JUMPBUG
				stdcall GetDistanceToGround
				fld [jumpbug_distance]
				fld [me.distance_to_ground]
				fcomip ST1
				fstp ST0
				ja .jb_prepare
					fld1
					fstp [clientSpeed]
					and [.cmd.buttons], not IN_DUCK
					or [.cmd.buttons], IN_JUMP
					btc [userButtons], UB_JUMPBUG
					jmp .end_JUMPBUG
				.jb_prepare:
					or [.cmd.buttons], IN_DUCK
					and [.cmd.buttons], not IN_JUMP
					
					fld [frametime]
					fld [pmove.velocity.z]
					fmulp ST1, ST0
					fchs
					fld [me.distance_to_ground]
					fcomip ST1
					fstp ST0
					ja .end_JUMPBUG
						fld1
						fld [frametime]
						fdivp ST1, ST0
						fstp [clientSpeed]
	endf
	
	mov eax, [oCL_CreateMove_result]
	ret
endp
