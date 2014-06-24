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

struct CvarHook_s
	org_name dd ?
	new_name dd ?
	psave dd ?
ends

align 4
ClientDLL_Interface_Version dd 0

pConsoleColor				dd ? ;ptr to Console text color
pConsoleDevColor			dd ? ;ptr to Console text color, when developer = 1
pushScreenFade				dd ? ;ptr to push OFFSET "ScreenFade"
pClientDLL					dd ? ;ptr to ClientDLL_s
pEngine						dd ? ;ptr to Engine_s
pushErrMsgClDLLStudioRI		dd ? ;ptr to push OFFSET "Couldn't get client .dll studio model rendering interface."
pEngineStudio				dd ?
pStudioInterface			dd ?
pRefreshFunc				dd ? ;ptr to Refresh function (where r_norefresh is checked)
pRefreshFuncOrigCalls		dd 6 dup ? ;6 original function calls in pRefreshFunc (that are required)
pRefreshFuncOrigAddrs		dd 2 dup ? ;2 original function addresses in pRefreshFunc

pClientSpeed				dd ? ;ptr to Client speed multiplier

pRegVarMallocCall			dd ? ;ptr to pfnRegisterVariable malloc call address

pRegisterCommandWithFlag	dd ? ;ptr to RegisterCommand with flag procedure
pRegCmdWFMallocCall			dd ? ;ptr to RegisterCommand with flag, malloc call address

pCvarFpsOverride			dd ? ;ptr to `fps_override` cvar_s

ClientDLL		ClientDLL_s
Engine			Engine_s

screenInfo		SCREENINFO_s
screenCenterX	dd ?
screenCenterY	dd ?

hookList_ClientDLL:
	chkftr <F_HOOK_HUD_REDRAW>,		<VTHook_s pClientDLL, ClientDLL_s.HUD_Redraw, HUD_Redraw>
	chkftr <F_HOOK_CL_CREATEMOVE>,	<VTHook_s pClientDLL, ClientDLL_s.CL_CreateMove, CL_CreateMove>
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

hookList_StudioInterface:
	;VTHook_s pStudioInterface, StudioInterface
	dd 0

cvarHookList:
	CvarHook_s cvar_fps_max + sizeof.PREFIX,			cvar_fps_max,			0
	CvarHook_s cvar_fps_override + sizeof.PREFIX,		cvar_fps_override,		pCvarFpsOverride
	dd 0


string cvar_fps_max,		PREFIX, 'fps_max'
string cvar_fps_override,	PREFIX, 'fps_override'


string szWelcomeMessage, 'flatcheat has been successfully loaded.', 10

string szErr_FailedToFindCvar_x,				'Failed to find cvar `%s`'
string szErr_RedirectClientSpeedMultiplierPtr,	'RedirectClientSpeedMultiplierPtr failed.', 13, 10, 'There was not exactly 30 redirections!'

refreshFuncPatchOrigFunc db 26, 14, 5, 14, 5, 5, 0
refreshFuncPatch db 	$83, $3D, $FF, $FF, $FF, $FF, $00, $75, $41, $55, $89, $E5, $83, $EC, $14, $C7, \
						$05, $C0, $62, $6F, $04, $00, $00, $00, $00, $E8, $FF, $FF, $FF, $FF, $A1, $6C, \
						$62, $6F, $04, $85, $C0, $75, $05, $E8, $FF, $FF, $FF, $FF, $E8, $FF, $FF, $FF, \
						$FF, $A1, $6C, $62, $6F, $04, $85, $C0, $75, $0A, $E8, $FF, $FF, $FF, $FF, $E8, \
						$FF, $FF, $FF, $FF, $E8, $FF, $FF, $FF, $FF, $C9, $C3, $90
sizeof.refreshFuncPatch = $ + 1 - refreshFuncPatch
