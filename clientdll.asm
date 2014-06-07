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
	
	if BHOP
		CL_CreateMove_bhop:
		cmp [bhop.value], 0.0
		je .no_bhop
			test [cmd.buttons], IN_JUMP
			jz .no_bhop
				test [pmove.flags], FL_ONGROUND
				jnz .no_bhop
					cmp [pmove.movetype], MOVETYPE_FLY
					je .no_bhop
						cmp [pmove.waterlevel], 2
						jge .no_bhop
							and [cmd.buttons], not IN_JUMP
		.no_bhop:
	end if
	
	;pop eax
	ret
endp
