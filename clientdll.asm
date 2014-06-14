proc HUD_Redraw c time, intermission
	cinvoke ClientDLL.HUD_Redraw, [time], [intermission]
	mov [oHUD_Redraw_result], eax
	
	inline_feature SI_HSPEED, <stdcall WriteDoublCenter, [SI_HSpeed_coord.x], [SI_HSpeed_coord.y], szHSpeed, szHSpeedData, double[me.horizontal_speed]>
	inline_feature SI_VSPEED, <stdcall WriteDoublCenter, [SI_VSpeed_coord.x], [SI_VSpeed_coord.y], szVSpeed, szVSpeedData, double[me.vertical_speed]>
	inline_feature SI_HEIGHT, <stdcall WriteDoublCenter, [SI_Height_coord.x], [SI_Height_coord.y], szHeight, szHeightData, double[me.distance_to_ground]>
	
	mov eax, [oHUD_Redraw_result]
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
	
	stdcall GetDistanceToGround
	stdcall GetPlayerSpeed
	
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
	
	feature GROUND_STRAFE
		bt [userButtons], UB_GROUNDSTRAFE
		jnc .end_GROUND_STRAFE
			cmp [.pmove.movetype], MOVETYPE_FLY
			je .end_GROUND_STRAFE
				test [.pmove.flags], FL_ONGROUND
				jz .gs_not_on_ground
					mov_dbl_const clientSpeed, 1.0
					test [.pmove.flags], FL_DUCKING
					jnz .gs_not_on_ground
						cmp [.pmove.bInDuck], 0
						jne .gs_not_on_ground
							or [.cmd.buttons], IN_DUCK
							jmp .end_GROUND_STRAFE
				.gs_not_on_ground:
				and [.cmd.buttons], not IN_DUCK
	endf
	
	feature STRAFE
		bt [userButtons], UB_STRAFE
		jnc .end_STRAFE
			fld [strafe_forwardmove.value]
			fld1
			fadd [me.horizontal_speed]
			fdivp ST1, ST0
			fstp [.cmd.forwardmove]
			fld [strafe_sidemove.value]
			fst [.cmd.sidemove]
			fchs
			fstp [strafe_sidemove.value]
	endf
	
	feature JUMPBUG
		bt [userButtons], UB_JUMPBUG
		jnc .end_JUMPBUG
			cmp [.pmove.movetype], MOVETYPE_FLY
			je .end_JUMPBUG
				fld [jumpbug_distance]
				fld [me.distance_to_ground]
				fcomip ST1
				fstp ST0
				ja .jb_prepare
					mov_dbl_const clientSpeed, 1.0
					and [.cmd.buttons], not IN_DUCK
					or [.cmd.buttons], IN_JUMP
					btr [userButtons], UB_JUMPBUG
					jmp .end_JUMPBUG
				.jb_prepare:
					or [.cmd.buttons], IN_DUCK
					and [.cmd.buttons], not IN_JUMP
					fld [frametime]
					fld [.pmove.velocity.z]
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
