proc Command_fps_boost
	cinvoke Engine.Cmd_Argv, 0
	cmp byte[eax], '+'
	jne .minus
	.plus:
		mov edx, 1.0
		cvtss2si eax, [fps_boost_skip_nframes.value]
		shl eax, 1 ;make it even (screen is not refreshed when it's odd)
		mov [showFrameN], eax
		mov [currentFrameN], eax
		mov [r_norefresh.value], edx
		bts [userButtons], UB_FPS_BOOST
		mov ecx, [pCvarFpsOverride]
		mov [ecx], edx
		ret
	.minus:
		mov [r_norefresh.value], 0.0
		btr [userButtons], UB_FPS_BOOST
		xor eax, eax
		mov ecx, [pCvarFpsOverride]
		mov [ecx], eax
		ret
endp

proc Command_fastrun
	cinvoke Engine.Cmd_Argv, 0
	cmp byte[eax], '+'
	jne .minus
	.plus:
		bts [userButtons], UB_FASTRUN
		ret
	.minus:
		btr [userButtons], UB_FASTRUN
		ret
endp

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
		if defined FPS_HELPER & FPS_HELPER
			cmp [strafe_use_fps_helper.value], 0.0
			je .p_skip_fps_helper
				mov eax, [strafe_use_fps_helper.value]
				xchg eax, [fps_helper.value]
				mov [strafe_use_fps_helper.value], eax
			.p_skip_fps_helper:
		end if
		cmp [strafe_use_fps_boost.value], 0.0
		jne Command_fps_boost.plus
		ret
	.minus:
		btr [userButtons], UB_STRAFE
		if defined FPS_HELPER & FPS_HELPER
			mov eax, [fps_helper.value]
			xchg eax, [strafe_use_fps_helper.value]
			mov [fps_helper.value], eax
		end if
		cmp [strafe_use_fps_boost.value], 0.0
		jne Command_fps_boost.minus
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

proc Command_groundstrafe_standup
	cinvoke Engine.Cmd_Argv, 0
	cmp byte[eax], '+'
	jne .minus
	.plus:
		bts [userButtons], UB_GROUNDSTRAFE
		bts [userButtons], UB_GROUNDSTRAFE_STANDUP
		ret
	.minus:
		btr [userButtons], UB_GROUNDSTRAFE_STANDUP
		btr [userButtons], UB_GROUNDSTRAFE
		ret
endp

proc Command_exec
	cinvoke Engine.Cmd_Argc
	cmp eax, 2
	je .exec

	.usage:
		cinvoke Engine.Con_Printf, szCmdExecUsage
		ret

	.exec:
		cinvoke Engine.Cmd_Argv, 1
		push eax
		call Exec
		ret
endp

proc Command_max_flash
	cinvoke Engine.Cmd_Argc
	cmp eax, 2
	jl .display
		cinvoke Engine.Cmd_Argv, 1
		atoi eax
		test eax, 0xFFFFFF00
		jnz .limit
		mov [maxFlashAlpha], al
		ret
	.display:
		movzx ecx, [maxFlashAlpha]
		cinvoke Engine.Con_Printf, szFmtCV_int, [max_flash.name], ecx
		ret
	.limit:
		cinvoke Engine.Con_Printf, szFmtLim_int, [max_flash.name], 0, 255
		ret
endp

proc Command_thirdperson
	cinvoke Engine.Cmd_Argv, 0
	mov edx, [pIsThirdPerson]
	cmp byte[eax], '+'
	jne .minus
	.plus:
		mov byte[edx], 1
		ret
	.minus:
		mov byte[edx], 0
		ret
endp
