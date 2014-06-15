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
	
	feature FASTRUN
		bt [userButtons], UB_FASTRUN
		jnc .end_FASTRUN
			test [.pmove.flags], FL_ONGROUND
			jz .end_FASTRUN
			
			mov eax, dword[.cmd.buttons]
			test eax, IN_FORWARD
			jz .fr_fwd_bck_ok
				test eax, IN_BACK
				jz .fr_fwd_bck_ok
					and eax, not (IN_FORWARD or IN_BACK)
			.fr_fwd_bck_ok:
			test eax, IN_MOVELEFT
			jz .fr_lft_rgt_ok
				test eax, IN_MOVERIGHT
				jz .fr_lft_rgt_ok
					and eax, not (IN_MOVELEFT or IN_MOVERIGHT)
			.fr_lft_rgt_ok:
			
			test eax, IN_FORWARD
			jnz .fr_fwd
			test eax, IN_BACK
			jnz .fr_bck
			test eax, IN_MOVERIGHT
			jnz .fr_rgt
			test eax, IN_MOVELEFT
			;jnz .fr_lft
			;jmp .end_FASTRUN
			jz .end_FASTRUN
			.fr_lft:
				mov [fastrun_movement_angle], 1.5707963267948966192313216916398 ;90.0 * cDEG_TO_RAD
				jmp .fr_begin
			.fr_rgt:
				mov [fastrun_movement_angle], -1.5707963267948966192313216916398 ;-90.0 * cDEG_TO_RAD
				jmp .fr_begin
			.fr_fwd:
				test eax, IN_MOVERIGHT
				jnz .fr_fwd_rgt
				test eax, IN_MOVELEFT
				jnz .fr_fwd_lft
					mov [fastrun_movement_angle], 0.0 ;0.0 * cDEG_TO_RAD
					jmp .fr_begin
				.fr_fwd_rgt:
					mov [fastrun_movement_angle], -0.78539816339744830961566084582005 ;-45.0 * cDEG_TO_RAD
					jmp .fr_begin
				.fr_fwd_lft:
					mov [fastrun_movement_angle], 0.78539816339744830961566084582005 ;45.0 * cDEG_TO_RAD
					jmp .fr_begin
			.fr_bck:
				test eax, IN_MOVELEFT
				jnz .fr_bck_lft
				test eax, IN_MOVERIGHT
				jnz .fr_bck_rgt
					mov [fastrun_movement_angle], 3.1415926535897932384626433832795 ;180.0 * cDEG_TO_RAD
					jmp .fr_begin
				.fr_bck_lft:
					mov [fastrun_movement_angle], 2.3561944901923449288469825374596 ;135.0 * cDEG_TO_RAD
					jmp .fr_begin
				.fr_bck_rgt:
					mov [fastrun_movement_angle], -2.3561944901923449288469825374596 ;-135.0 * cDEG_TO_RAD
					;jmp .fr_begin

			.fr_begin:
			fld [.cmd.viewangles.y]
			fmul [flDEG_TO_RAD]
			
			fld [.pmove.velocity.y]
			fld [.pmove.velocity.x]
			fpatan
			;ST0 = atan2(.pmove.velocity.y, .pmove.velocity.x)
			fsub [fastrun_movement_angle]
			fsubp ST1, ST0
			;ST0 = difference between movement angle and view angle
			fst [fastrun_angle_diff_flt]
			fmul [flRAD_TO_DEG]
			fistp [fastrun_angle_diff_int]

			fld [fastrun_sidemove.value]
			
			mov ecx, 360
			xor edx, edx
			mov eax, [fastrun_angle_diff_int]
			add eax, ecx
			div ecx
			shr ecx, 1
			cmp edx, ecx
			ja .pos
			fchs
			.pos:
			stc
			
			fld [fastrun_forwardmove.value]
			fldz
			fcmovb ST0, ST2
			fld [fastrun_forwardmove.value]
			
			fld [fastrun_movement_angle]
			fsincos ;FPU: 0cos, 1sin, 2fwd, 3sid, 4fwd, 5sid
			fldz
			fcmovb ST0, ST2
			fldz
			fcmovb ST0, ST2
			;ST0 = cos(angle diff)
			;ST1 = sin(angle diff)
			;ST2 = cos(angle diff)
			;ST3 = sin(angle diff)
			;ST4 = fastrun_forwardmove.value
			;ST5 = fastrun_sidemove.value
			;ST6 = fastrun_forwardmove.value
			;ST7 = fastrun_sidemove.value
			fmulp ST5, ST0
			fmulp ST3, ST0
			fmulp ST4, ST0
			fmulp ST4, ST0
			fsubp ST1, ST0
			fst ST3
			fstp ST5
			faddp ST1, ST0
			fst ST2
			;ST0,ST2 = fastrun_forwardmove.value * cos(angle diff) + fastrun_sidemove.value * sin(angle diff)
			;ST1,ST3 = fastrun_sidemove.value * cos(angle diff) - fastrun_forwardmove.value * sin(angle diff)
			
			fld [fastrun_angle_diff_flt]
			fchs
			fsincos
			;ST0 = cos(angle diff)
			;ST1 = sin(angle diff)
			
			fldz
			fcmovb ST0, ST2
			fldz
			fcmovb ST0, ST2
			
			;ST0 = cos(angle diff)
			;ST1 = sin(angle diff)
			;ST2 = cos(angle diff)
			;ST3 = sin(angle diff)
			;ST4 = fastrun_forwardmove.value
			;ST5 = fastrun_sidemove.value
			;ST6 = fastrun_forwardmove.value
			;ST7 = fastrun_sidemove.value
			fmulp ST5, ST0
			fmulp ST3, ST0
			fmulp ST4, ST0
			fmulp ST4, ST0
			fsubp ST1, ST0
			fstp [.cmd.sidemove]
			faddp ST1, ST0
			fstp [.cmd.forwardmove]
	endf
	
	feature BHOP
		cmp [bhop.value], 0.0
		je .end_BHOP
			test dword[.cmd.buttons], IN_JUMP
			jz .end_BHOP
				feature BHOP_STANDUP
					cmp [bhop_standup.value], 0.0
					je .end_BHOP_STANDUP
						fld [bhop_standup_fallingspeed.value]
						fld [.pmove.flFallVelocity]
						fcomip ST1
						fstp ST0
						jbe .end_BHOP_STANDUP
							or dword[.cmd.buttons], IN_DUCK
				endf
				test [.pmove.flags], FL_ONGROUND
				jnz .end_BHOP
					cmp [.pmove.movetype], MOVETYPE_FLY
					je .end_BHOP
						cmp [.pmove.waterlevel], 2
						jge .end_BHOP
							and dword[.cmd.buttons], not IN_JUMP
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
							or dword[.cmd.buttons], IN_DUCK
							jmp .end_GROUND_STRAFE
				.gs_not_on_ground:
				and dword[.cmd.buttons], not IN_DUCK
	endf
	
	feature STRAFE
		bt [userButtons], UB_STRAFE
		jnc .end_STRAFE
			test [.pmove.flags], FL_ONGROUND
			jnz .end_STRAFE
			
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
					and dword[.cmd.buttons], not IN_DUCK
					or dword[.cmd.buttons], IN_JUMP
					btr [userButtons], UB_JUMPBUG
					jmp .end_JUMPBUG
				.jb_prepare:
					or dword[.cmd.buttons], IN_DUCK
					and dword[.cmd.buttons], not IN_JUMP
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
