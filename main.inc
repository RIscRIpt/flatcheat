struct VTHook_s
	table dd ?
	table_offset dd ?
	new_func dd ?
ends

struct VTRestore_s
	table dd ?
	table_orig dd ?
	table_offset dd ?
ends

szWelcomeMessage db	'flatcheat has been successfully loaded.', 0

if MAX_PREFIX_LENGTH > 0
	if MAX_PREFIX_LENGTH <= 127
		prefix db MAX_PREFIX_LENGTH + 1 dup 0
		sizeof.prefix = $ - prefix
	else
		display 'Are you crazy, or what? Why do you need so long prefix?', 13, 10
		err
	end if
end if

string szPrefixFilename, 'prefix.ini'


align 4
ClientDLL_Interface_Version dd 0

ppCmdList			dd ? ;ptr to ptr to command_s
pConsoleColor		dd ? ;ptr to Console text color
pConsoleDevColor	dd ? ;ptr to Console text color, when developer = 1
pushScreenFade		dd ? ;ptr to push OFFSET "ScreenFade"
pClientDLL			dd ? ;ptr to ClientDLL_s
pEngine				dd ? ;ptr to Engine_s

ClientDLL	ClientDLL_s
Engine		Engine_s

hookList_ClientDLL:
	VTHook_s pClientDLL, ClientDLL_s.CL_CreateMove, CL_CreateMove
	;VTHook_s pClientDLL, ClientDLL_s.HUD_PlayerMove, HUD_PlayerMove
	dd 0

hookList_Engine:
	VTHook_s pEngine, Engine_s.pfnHookEvent, pfnHookEvent
	VTHook_s pEngine, Engine_s.pfnHookUserMsg, pfnHookUserMsg
	VTHook_s pEngine, Engine_s.pfnAddCommand, pfnAddCommand
	VTHook_s pEngine, Engine_s.pfnRegisterVariable, pfnRegisterVariable
	dd 0

restoreList_Engine:
	VTRestore_s pEngine, Engine, Engine_s.pfnHookEvent
	VTRestore_s pEngine, Engine, Engine_s.pfnHookUserMsg
	VTRestore_s pEngine, Engine, Engine_s.pfnAddCommand
	VTRestore_s pEngine, Engine, Engine_s.pfnRegisterVariable
	dd 0
