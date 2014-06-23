format PE GUI 5.0 DLL

include 'win32ax.inc'
include 'windef.inc'
include 'macro/exmacro.inc'
include 'macro/print.inc'
include 'cs_types.inc'
include '../features.ini'
include 'feature_math.inc'

entry DllMain

section '.data' data readable writeable
	self dd ?
	hlexe dd ?
	processHeap dd ?
	
	include 'main.inc'
	include 'auto_offsets/auto_offsets.inc'
	
	include 'fc_cmds/cmds.inc'
	include 'fc_cvars/cvars.inc'
	include 'player_data/player_data.inc'
	include 'calculations/physics_calc.inc'
	include 'calculations/intel_approx_math_lib.inc'
	include 'clientdll/clientdll.inc'
	include 'engine/engine.inc'
	include 'drawing/drawing.inc'
	include 'fc_cmds/cmd_funcs.inc'
	
	include 'utilities/utilities.inc'

	rootDir dw MAX_PATH + 1 dup 0
	
	szError db 'Error', 0
	szFatalError db	'flatcheat has stopped working', 13, 10,\
					'Error #'
	FatalErrorNo db	'00000000', 0

section '.code' code readable writeable executable

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
	
	;should be cdecl, but this procedure exits the process
	ShowFatalError: ;fmt, va_list
		mov ebp, esp
		sub esp, 256 ;[ebp - 256] = char buffer[256];
		mov edi, esp
		lea ecx, [ebp + 4]
		invoke vsprintf, edi, dword[ebp], ecx
		cmp eax, 0
		jle FatalError
		invoke MessageBoxA, HWND_DESKTOP, edi, szError, MB_ICONERROR
		invoke ExitProcess, 0
		int3
	
	include 'utilities/utilities.asm'

	proc DllMain hinstDLL, fdwReason, lpvReserved
		cmp [fdwReason], DLL_PROCESS_ATTACH ;won't be called with another reason due to HideDLL
		jne .done
		
		mov eax, [hinstDLL]
		mov [self], eax

		invoke GetCurrentProcess
		mov [hlexe], eax
		
		invoke GetProcessHeap
		test eax, eax
		jz FatalError
		mov [processHeap], eax
		
		stdcall GetRootDir
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
	
	include 'dynamic_api/dynwinapi.asm'
	include 'hide_dll.asm'
	include 'main.asm'
	include 'auto_offsets/auto_offsets.asm'
	
	include 'fc_cmds/cmds.asm'
	include 'fc_cvars/cvars.asm'
	include 'player_data/player_data.asm'
	include 'calculations/physics_calc.asm'
	include 'clientdll/clientdll.asm'
	include 'engine/engine.asm'
	include 'drawing/drawing.asm'
	include 'fc_cmds/cmd_funcs.asm'

section '.idata' import data readable writeable
	library	kernel32,	'kernel32.dll',\
			user32,		'user32.dll',\
			advapi32,	'advapi32.dll',\
			msvcrt,		'msvcrt.dll'
	
	include 'api/kernel32.inc'
	include 'api/user32.inc'
	include 'api/advapi32.inc'
	import msvcrt,\
		atof,		'atof',\
		gcvt,		'_gcvt',\
		sprintf,	'sprintf',\
		vsprintf,	'vsprintf',\
		swprintf,	'swprintf'

	include 'dynamic_api/dynwinapi.inc'

section '.reloc' fixups data readable discardable
