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

proc Command_exec
	define CMD_EXEC_STATE_NL_SEARCH 1
	local hfile dd ?
	local bread dd ?
	local pbuf dd ?
	local eob dd ?
	local buflen dd 256
	local prevstate dd ?
	local in_quite dd 0
	cinvoke Engine.Cmd_Argc
	cmp eax, 2
	jne .usage
		cinvoke Engine.Cmd_Argv, 1
		invoke MultiByteToWideChar, CP_UTF8, 0, eax, -1, unicodeBuffer, MAX_PATH
		cinvoke swprintf, wcsScriptPath, wcsFmtPath, rootDir, unicodeBuffer
		
		invoke CreateFileW, wcsScriptPath, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0
		test eax, eax
		jz .fail_open
		mov [hfile], eax
		
		invoke HeapAlloc, [processHeap], 0, [buflen]
		test eax, eax
		jz .fail_alloc
		mov ebx, eax
		mov [pbuf], ebx
		
		.read_loop:
			;calculate count of bytes to read
			mov ecx, ebx
			sub ecx, [pbuf]
			neg ecx
			add ecx, [buflen]
			lea eax, [bread]
			invoke ReadFile, [hfile], ebx, ecx, eax, 0
			test eax, eax
			jz .fail_read
			
			mov edi, [pbuf]
			mov ebx, edi
			mov [eob], ebx
			mov ecx, [bread]
			add [eob], ecx
			test ecx, ecx
			jz .done
			
			.process_buffer:
				cmp byte[edi], 10
				je .process_line
				cmp byte[edi], '"'
				je .process_quote
				cmp byte[in_quite], 0
				jne .skip_comment_check
					cmp word[edi], '//'
					je .process_comment
				.skip_comment_check:
				inc edi
				cmp edi, [eob]
				jne .process_buffer
				jmp .process_small_buffer
				
			.process_line:
				mov byte[edi], 0
				cmp byte[edi - 1], 13
				jne .skip_carriage_ret
					mov byte[edi - 1], 0
				.skip_carriage_ret:
				cinvoke Engine.pfnClientCmd, ebx
				inc edi
				mov ebx, edi
				mov [in_quite], 0
				jmp .process_buffer
			
			.process_quote:
				not [in_quite]
				inc edi
				jmp .process_buffer
			
			.process_comment:
				mov byte[edi], 0
				cinvoke Engine.pfnClientCmd, ebx
				mov al, 10 ;new line
				repne scasb
				je .nl_found
					;new line not found
					mov [prevstate], CMD_EXEC_STATE_NL_SEARCH
					mov ebx, [pbuf]
					jmp .read_loop
				.nl_found:
					;new line found
					inc edi
					mov ebx, edi
					jmp .process_buffer
			
			.process_small_buffer:
				cmp edi, ebx
				je .increase_buffer
					;copy contents to the beginning of the buffer
					mov esi, edi
					mov edi, [pbuf]
					mov ebx, [pbuf]
					add ebx, ecx
					repne movsb
					jmp .read_loop
				.increase_buffer:
					mov eax, [buflen]
					shl eax, 1
					invoke HeapReAlloc, [processHeap], 0, [pbuf], eax
					test eax, eax
					jz .fail_alloc
					mov [pbuf], eax
					;TODO: Recalculate read pointer
					jmp .read_loop
		jmp .ret
	.fail_open:
		mov esi, szCmdExecFailOpen
		jmp .fail
	.fail_alloc:
		invoke CloseHandle, [hfile]
		mov esi, szCmdExecFailHAlloc
		jmp .fail
	.fail_read:
		invoke HeapFree, [pbuf]
		invoke CloseHandle, [hfile]
		mov esi, szCmdExecFailRead
		;jmp .fail
	.fail:
		cinvoke Engine.Cmd_Argv, 1
		mov ebx, eax
		invoke GetLastError
		cinvoke Engine.Con_Printf, esi, ebx, eax
		jmp .ret
	.done:
		invoke HeapFree, [pbuf]
		invoke CloseHandle, [hfile]
		jmp .ret
	.usage:
		cinvoke Engine.Con_Printf, szCmdExecUsage
	.ret:
		ret
	restore CMD_EXEC_STATE_NL_SEARCH
endp
