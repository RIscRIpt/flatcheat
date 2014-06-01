format PE GUI 5.0 DLL

include 'win32a.inc'
include 'windef.inc'
include 'exmacro.inc'

include 'cs_types.inc'
include 'features.inc'

entry DllMain

section '.data' data readable writeable
	self dd ?
	hlexe dd ?
	include 'main.inc'
	include 'auto_offsets.inc'
	
	include 'local_player_data.inc'
	include 'clientdll.inc'
	include 'engine.inc'

	szError db 'Error', 0
	szFatalError db	'flatcheat has stopped working', 13, 10,\
					'Error #'
	FatalErrorNo db	'00000000', 0

section '.code' code readable executable

	FatalError:
		invoke GetLastError
		mov edx, eax
		mov edi, FatalErrorNo + 8 - 1
		std ;for stosb backwards
		.write_err:
			mov al, dl
			and al, 0x0F
			add al, '0'
			cmp al, '9'
			jle .skip_hex
				add al, 'A' - '9' - 1
			.skip_hex:
			stosb
			shr edx, 4
			test edx, edx
			jnz .write_err
		cld ;winapi can crash(?) if df=1
		invoke MessageBoxA, HWND_DESKTOP, szFatalError, szError, MB_ICONERROR
		invoke ExitProcess, 0
		int3
	
	proc ShowFatalError, message
		invoke MessageBoxA, HWND_DESKTOP, [message], szError, MB_ICONERROR
		invoke ExitProcess, 0
		int3
	endp
	
	include 'utilities.asm'

	proc DllMain hinstDLL, fdwReason, lpvReserved
		cmp [fdwReason], DLL_PROCESS_ATTACH ;won't be called with another reason due to HideDLL
		jne .done
		
		mov eax, [hinstDLL]
		mov [self], eax

		invoke GetCurrentProcess
		mov [hlexe], eax
		
		stdcall HideDLL
		stdcall LoadDynamicAPI
		
		invoke CreateThread, 0, 0, flatcheat_inject, 0, 0, 0
		test eax, eax
		jz FatalError
		
		invoke CloseHandle, eax
		mov eax, 1 ;return 1 even if CloseHandle failed, because thread has been created successfully.
		jmp .done
		
		.done:
		ret
	endp
	
	include 'dynapi.asm'
	include 'hide_dll.asm'
	include 'main.asm'
	include 'auto_offsets.asm'
	
	include 'local_player_data.asm'
	include 'clientdll.asm'
	include 'engine.asm'

section '.idata' import data readable writeable
	library	kernel32,	'kernel32.dll',\
			user32,		'user32.dll'
	
	include 'api/kernel32.inc'
	include 'api/user32.inc'

	include 'dynapi.inc'

section '.reloc' fixups data readable discardable
