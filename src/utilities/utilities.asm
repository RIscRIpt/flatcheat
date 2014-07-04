proc asm_memcpy
	mov eax, ecx
	and eax, 0011b ;3
	shr ecx, 2 ;div 4
	rep movsd
	mov ecx, eax
	rep movsb
	ret
endp

macro memcpy dest, src, len {
	mov edi, dest
	mov esi, src
	mov ecx, len
	stdcall asm_memcpy
}

proc asm_atoi
	xor eax, eax
	xor edx, edx
	.loop:
	mov dl, byte[ecx]
	test dl, dl
	jz .ret
	sub dl, '0'
	cmp dl, 9
	ja .invalid
	imul eax, eax, 10
	jo .invalid
	add eax, edx
	inc ecx
	jmp .loop
	.invalid:
	xor eax, eax
	.ret:
	ret
endp

macro atoi s {
	mov ecx, s
	stdcall asm_atoi
}

proc asm_itoa
	test ebx, ebx
	jz .zero
	mov ecx, divTable
	.skip_loop:
	xor edx, edx
	mov eax, ebx
	div dword[ecx]
	add ecx, 4
	test eax, eax
	jz .skip_loop
	jmp .begin_loop
	.loop:
	mov eax, edx
	xor edx, edx
	div dword[ecx]
	add ecx, 4
	.begin_loop:
	add al, '0'
	mov byte[edi], al
	inc edi
	cmp ecx, divTableEnd
	jne .loop
	mov byte[edi], 0
	ret
	.zero:
	mov dword[edi], '0'
	ret
endp

macro itoa val, dest {
	if ~ val eq ebx
		mov ebx, val
	end if
	mov edi, dest
	stdcall asm_itoa
}

proc FindRefCallAddr start, size, address
	mov edi, [start]
	mov edx, [address]
	mov ecx, [size]
	sub edx, 4
	mov al, ASM_INSTR_CALL
	
	.cont:
	repne scasb
	jne .not_found
	
	mov ebx, edx
	sub ebx, edi
	cmp dword[edi], ebx
	je .found
	
	;Assume E8 byte cannot be found less than 5 bytes
	;before another real call instruction
	add edi, 4
	sub ecx, 4
	jmp .cont
	
	.not_found:
	mov edi, 1
	.found:
	lea eax, [edi - 1]
	ret
endp

proc FindBytePattern start, size, pattern, pattern_size
	mov edi, [start]
	mov edx, [size]
	mov eax, [pattern]
	mov al, [eax]
	inc [pattern]
	dec [pattern_size]
	
	.next:
	mov ecx, edx
	repne scasb
	jne .not_found
	
	mov edx, ecx
	mov ecx, [pattern_size]
	mov esi, [pattern]
	mov ebx, edi
	
	.cont:
	repe cmpsb
	je .found

	cmp byte[esi - 1], 0xFF
	je .cont
	
	mov edi, ebx
	jmp .next
	
	.not_found:
	mov ebx, 1
	.found:
	lea eax, [ebx - 1]
	ret
endp

macro FindRefWithPrefix start, size, prefix, prefix_size, address {
	sub esp, 4 + prefix_size
	if prefix_size = 0
	else if prefix_size = 1
		mov byte[esp], byte prefix
	else if prefix_size = 2
		mov word[esp], word prefix
	else if prefix_size = 4
		mov dword[esp], dword prefix
	else
		display 'Unsupported FindRefWithPrefix prefix_size', 13, 10
		err
	end if
	if address eqtype [0]
		mov eax, address
		mov dword[esp + prefix_size], eax
	else
		mov dword[esp + prefix_size], address
	end if
	mov eax, esp
	stdcall FindBytePattern, start, size, eax, 4 + prefix_size
	add esp, 4 + prefix_size
}

proc GetCmdByNameL szCmdName, cmdNameLen
	cinvoke Engine.pfnGetCmdList
	mov eax, [eax]
	virtual at eax
		.cmd command_s
	end virtual
	mov edx, [cmdNameLen]
	mov ebx, [szCmdName]
	.next:
	mov ecx, edx
	mov edi, ebx
	mov esi, [.cmd.name]
	repe cmpsb
	je .found
	mov eax, [.cmd.next]
	test eax, eax
	jnz .next
	.found:
	ret
endp

proc VirtualProtect_s ;lpAddress, dwSize, flNewProtect, lpflOldProtect
	;Jumping into VirtualProtect without re-pushing parameters
	;Save original return address
	mov eax, [esp]
	mov [.orig_ret + 1], eax
	sub dword[.orig_ret + 1], .orig_ret + 5
	;Set new return address
	mov dword[esp], .return
	jmp [VirtualProtect]
	.return:
	test eax, eax
	jnz .orig_ret
	stdcall ShowFatalError, szErr_VirtualProtect_s
	.orig_ret:
	jmp near .orig_ret ;force 4byte jmp, (jmp dest is modified above)
endp

proc GetRootDir
	invoke GetModuleFileNameW, [self], rootDir, MAX_PATH
	test eax, eax
	jz FatalError
	
	std
	mov ecx, eax
	shl eax, 1
	mov edi, rootDir
	add edi, eax
	mov ax, '\'
	repne scasw
	cld ;WinAPI hangs if DF=1

	mov word[edi + 2], 0
	ret
endp

proc Exec filename
	EXEC_BUFFER_SIZE = 4096 ;buffer for commands
	EXEC_BUFFER_SIZE_EX = 4096 ;buffer for prefix extension
	locals
		.hfile dd ?
		.bread dd ?
		.nline dd ?
		.buffer dd ?
		.in_quote dd ?
		.search_nl dd ?
	endl

	invoke MultiByteToWideChar, CP_UTF8, 0, [filename], -1, unicodeBuffer, MAX_PATH
	cinvoke swprintf, wcsScriptPath, wcsFmtPath, rootDir, unicodeBuffer
	invoke CreateFileW, wcsScriptPath, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0
	inc eax
	test eax, eax
	jz .fail_open
	
	mov [.hfile], eax
	
	invoke HeapAlloc, [processHeap], 0, EXEC_BUFFER_SIZE + EXEC_BUFFER_SIZE_EX
	test eax, eax
	jz .fail_halloc
	
	mov [.buffer], eax
	
	xor edx, edx
	mov ebx, [.buffer]
	mov [.in_quote], edx
	mov [.search_nl], edx
	inc edx
	mov [.nline], edx
	mov edi, ebx

	;edi - read pointer
	;ebx - command pointer
	
	.read_loop:
		mov esi, edi
	.read_more:
		lea eax, [.bread]
		mov ecx, [.buffer]
		add ecx, EXEC_BUFFER_SIZE - 1
		sub ecx, edi
		invoke ReadFile, [.hfile], edi, ecx, eax, 0
		test eax, eax
		jz .fail_read
					
		mov eax, [.bread]
		mov byte[edi + eax], 0
		
		mov edi, esi
		
		cmp byte[.search_nl], 0
		jne .search_newline
		
		mov ecx, [.in_quote]
		
		.process_buffer:
			mov eax, [edi]
			cmp al, '"'
			je .process_quote
			cmp al, 10
			je .process_line_nl
			cmp al, ';'
			je .process_line
			test ecx, ecx
			jne .skip_comment_check
				cmp ax, '//'
				je .process_comment
			.skip_comment_check:
			cmp eax, 'pfx#'
			je .process_prefix
			test al, al
			jz .process_eob
			inc edi
			jmp .process_buffer

		.process_quote:
			not ecx
			not [.in_quote]
			inc edi
			jmp .process_buffer

		.process_eob:
			cmp [.bread], 0
			je .process_last_line

			mov ecx, edi
			sub ecx, ebx
			cmp ecx, EXEC_BUFFER_SIZE
			je .process_too_long_line
			mov esi, ebx
			mov edi, [.buffer]
			mov ebx, edi
			rep movsb
			
			;check if possible pfx# is at the end
			mov ecx, 3
			mov eax, [edi - 3]
			and eax, 0xFFFFFF
			cmp eax, 'pfx'
			je .possible_pfx
			dec ecx
			shr eax, 8
			cmp ax, 'pf'
			je .possible_pfx
			dec ecx
			shr eax, 8
			cmp al, 'p'
			je .possible_pfx
			dec ecx
			.possible_pfx:
			mov esi, edi
			sub esi, ecx
			jmp .read_more

		.process_line_nl:
			cmp byte[edi - 1], 13
			jne .process_line
				mov byte[edi - 1], 0
		.process_line:
			mov byte[edi], 0
			inc [.nline]
			cinvoke Engine.pfnClientCmd, ebx
			inc edi
			mov ebx, edi
			xor ecx, ecx
			mov [.in_quote], ecx
			jmp .process_buffer
		
		.process_comment:
			mov byte[edi], 0
			cinvoke Engine.pfnClientCmd, ebx
			
		.search_newline:
			mov al, 10 ;new line
			mov ecx, [.buffer]
			add ecx, [.bread]
			sub ecx, edi
			repne scasb
			je .nl_found
				;new line not found
				inc [.search_nl]
				mov ebx, [.buffer]
				mov edi, ebx
				jmp .read_loop
			.nl_found:
				inc [.nline]
				;new line found
				xor edx, edx
				mov [.search_nl], edx
				mov ebx, edi
				xor ecx, ecx
				mov [.in_quote], ecx
				jmp .process_buffer
		
		.process_prefix:
			if sizeof.PREFIX = 4
				mov dword[edi], PREFIX
				add edi, 4
			else if sizeof.PREFIX < 4
				std ;shift >> parsed contents (4 - sizeof.PREFIX) times
				mov dword[edi], PREFIX shl (8 * (4 - sizeof.PREFIX))
				lea edx, [edi + 4]
				lea esi, [edi - 1]
				mov ecx, edi
				if ~ sizeof.PREFIX = 3
					add edi, 4 - sizeof.PREFIX - 1
				end if
				sub ecx, ebx
				rep movsb
				mov edi, edx
				add ebx, 4 - sizeof.PREFIX
				cld
			else ;sizeof.PREFIX > 4
				;check if enough buffer before `edi`
				mov eax, [.buffer]
				sub eax, ebx
				neg eax
				cmp eax, sizeof.PREFIX
				jl .not_enough
					;enough, allocate space for prefix before `edi`
					lea edx, [edi - (sizeof.PREFIX - 4)]
					mov ecx, edx
					lea edi, [ebx - (sizeof.PREFIX - 4)]
					mov esi, ebx
					sub ecx, esi
					inc ecx
					rep movsb
					sub ebx, sizeof.PREFIX - 4
					jmp .prefix_space_allocated
				.not_enough:
					;check if buffer is full
					mov ecx, [.bread]
					cmp ecx, EXEC_BUFFER_SIZE + EXEC_BUFFER_SIZE_EX - sizeof.PREFIX - 1
					jg .process_full_buffer ;not likely to happen
						std ;if buffer is not full, extend it
						mov edx, edi
						mov eax, [.buffer]
						lea esi, [eax + ecx - 1]
						lea edi, [esi + (sizeof.PREFIX - 4)]
						mov ecx, edi
						sub ecx, edx	; +4 (copying by 4 bytes more than needed),
										;so we could use edx in .prefix_space_allocated
						mov byte[edi + 1], 0 ;add null terminator
						rep movsb
						cld
						add [.bread], sizeof.PREFIX - 4
						jmp .prefix_space_allocated
					; .full:
						; std ;truncate end of buffer, shift buffer right
						; mov edx, edi
						; mov eax, [.buffer]
						; lea edi, [eax + ecx - 1]
						; lea esi, [edi - (sizeof.PREFIX - 4)]
						; mov ecx, esi
						; sub ecx, edx	; +4 (copying by 4 bytes more than needed),
										; ;so we could use edx in .prefix_space_allocated
						; rep movsb
						; cld
					.prefix_space_allocated:
						mov edi, edx
						mov esi, cvarNameDump ;first bytes must be prefix there
						mov ecx, sizeof.PREFIX
						rep movsb
			end if
			
			mov ecx, [.in_quote]
			jmp .process_buffer
		
		.process_too_long_line:
			cinvoke Engine.Con_Printf, szErr_ExecTooLongLine, [filename], [.nline]
			inc [.search_nl]
			mov ebx, [.buffer]
			mov edi, ebx
			jmp .read_loop
		
		.process_full_buffer:
			cinvoke Engine.Con_Printf, szErr_ExecExBufOverflow, [filename], [.nline]
			jmp .done
			
	.process_last_line:
		cinvoke Engine.pfnClientCmd, ebx
	.done:
		invoke HeapFree, [processHeap], 0, [.buffer]
		invoke CloseHandle, [.hfile]
		ret
	
	.fail_open:
		mov esi, szErr_ExecFailOpen
		jmp .fail
	.fail_halloc:
		invoke CloseHandle, [.hfile]
		mov esi, szErr_ExecFailHAlloc
		jmp .fail
	.fail_read:
		invoke HeapFree, [processHeap], 0, [.buffer]
		invoke CloseHandle, [.hfile]
		mov esi, szErr_ExecFailRead
		;jmp .fail
	.fail:
		invoke GetLastError
		cinvoke Engine.Con_Printf, esi, [filename], eax
		ret
endp