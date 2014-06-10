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

;cmd equ esi ;according to debugged info:
;8D3495 682B9C04      LEA ESI,[EDX*4+hw.49C2B68] | ESI = 049C32D4 (var)
;in CL_CreateMove 2nd arg (esp + 8) = 049C32D4 (var)
;=> ESI = cmd (usercmd_s)
proc CL_CreateMove c frametime, _cmd, active
	cinvoke ClientDLL.CL_CreateMove, [frametime], [_cmd], [active]
	;push eax
	
	mov edi, [me.ppmove]
	virtual at edi
		pmove playermove_s
	end virtual
	
	virtual at esi
		cmd usercmd_s
	end virtual
	
	feature BHOP
		cmp [bhop.value], 0.0
		je .end_BHOP
			test [cmd.buttons], IN_JUMP
			jz .end_BHOP
				feature BHOP_STANDUP
					cmp [bhop_standup.value], 0.0
					je .end_BHOP_STANDUP
						fldz
						fld [pmove.flFallVelocity]
						fcomip ST1
						fstp ST0
						jbe .end_BHOP_STANDUP
							or [cmd.buttons], IN_DUCK
				endf
				test [pmove.flags], FL_ONGROUND
				jnz .end_BHOP
					cmp [pmove.movetype], MOVETYPE_FLY
					je .end_BHOP
						cmp [pmove.waterlevel], 2
						jge .end_BHOP
							and [cmd.buttons], not IN_JUMP
	endf
	
	;pop eax
	ret
endp
