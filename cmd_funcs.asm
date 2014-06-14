proc Command_jumpbug
	cinvoke Engine.Cmd_Argv, 0
	cmp byte[eax], '+'
	jne .minus
	.plus:
		bts [userButtons], UB_JUMPBUG
		ret
	.minus:
		btr [userButtons], UB_JUMPBUG
		ret
endp

proc Command_strafe
	cinvoke Engine.Cmd_Argv, 0
	cmp byte[eax], '+'
	jne .minus
	.plus:
		bts [userButtons], UB_STRAFE
		ret
	.minus:
		btr [userButtons], UB_STRAFE
		ret
endp

proc Command_groundstrafe
	cinvoke Engine.Cmd_Argv, 0
	cmp byte[eax], '+'
	jne .minus
	.plus:
		bts [userButtons], UB_GROUNDSTRAFE
		ret
	.minus:
		btr [userButtons], UB_GROUNDSTRAFE
		ret
endp

; proc Command_speed
	; cinvoke Engine.Cmd_Argc
	; cmp eax, 1
	; jne .set
	; .get:
		; cinvoke Engine.Con_Printf, szSpeedValue, dword[clientSpeed], dword[clientSpeed + 4]
		; ret
	; .set:
		; cinvoke Engine.Cmd_Argv, 1
		; cinvoke atof, eax
		; fstp qword[clientSpeed]
		; ret
; endp
