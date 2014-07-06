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
pScreenPrintColor			dd ? ;ptr to Screen text color (that is used by pfnDrawConsoleString)
pushScreenFade				dd ? ;ptr to push OFFSET "ScreenFade"
pushStarBot					dd ? ;ptr to push OFFSET "*bot"
pClientDLL					dd ? ;ptr to ClientDLL_s
pEngine						dd ? ;ptr to Engine_s
pushErrMsgClDLLStudioRI		dd ? ;ptr to push OFFSET "Couldn't get client .dll studio model rendering interface."
pEngineStudio				dd ?
pStudioInterface			dd ?
pStudioModelRender			dd ?
pRefreshFunc				dd ? ;ptr to Refresh function (where r_norefresh is checked)
pRefreshFuncOrigCalls		dd 6 dup ? ;6 original function calls in pRefreshFunc (that are required)
pRefreshFuncOrigAddrs		dd 2 dup ? ;2 original function addresses in pRefreshFunc
pLimitConnectionCvarsFunc	dd ?
pSetinfoJmpPatchPlace		dd ?
pViewMatrix					dd ? ;(not sure if it's really viewmatrix) used in WorldToScreen (and CalcScreen)
pWorldToScreen				dd ? ;ptr to original function WorldToScreen (in hw.dll)
pCSPlayerInfo				dd ? ;ptr to CS cs_player_info_s

pClientSpeed				dd ? ;ptr to Client speed multiplier
pClientTime					dd ? ;ptr to Client time
pScreenFade					dd ? ;ptr to Client screenfade_s struct
pIsThirdPerson				dd ? ;ptr to IsThirdPerson value that is used by CL_IsThirdPerson for cam_command

pRegVarMallocCall			dd ? ;ptr to pfnRegisterVariable malloc call address

pRegisterCommandWithFlag	dd ? ;ptr to RegisterCommand with flag procedure
pRegCmdWFMallocCall			dd ? ;ptr to RegisterCommand with flag, malloc call address

pCvarFpsOverride			dd ? ;ptr to `fps_override` cvar_s

pDrawConStrResetColorCall	dd ? ;ptr to call procedure in pfnDrawConsoleString to reset drawing color


ClientDLL		ClientDLL_s
Engine			Engine_s

EngineStudio		EngineStudio_s
StudioInterface		StudioInterface_s
StudioModelRender	StudioModelRender_s

screenInfo		SCREENINFO_s
screenCenterX	dd ?
screenCenterY	dd ?

hookList_ClientDLL:
	chkftr <F_HOOK_HUD_REDRAW>,		<VTHook_s pClientDLL, ClientDLL_s.HUD_Redraw, HUD_Redraw>
	chkftr <F_HOOK_CL_CREATEMOVE>,	<VTHook_s pClientDLL, ClientDLL_s.CL_CreateMove, CL_CreateMove>
	chkftr <F_HOOK_HUD_ADDENTITY>,	<VTHook_s pClientDLL, ClientDLL_s.HUD_AddEntity, HUD_AddEntity>
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

hookList_StudioModelRender:
	chkftr <F_HOOK_STUDIOMODELRENDER>,	<VTHook_s pStudioModelRender, StudioModelRender_s.StudioRenderModel, StudioRenderModel>
	dd 0

cvarHookList:
	CvarHook_s cvar_fps_max + sizeof.PREFIX,			cvar_fps_max,			0
	CvarHook_s cvar_fps_override + sizeof.PREFIX,		cvar_fps_override,		pCvarFpsOverride
	CvarHook_s cvar_ex_interp + sizeof.PREFIX,			cvar_ex_interp,			0
	dd 0


string cvar_fps_max,		PREFIX, 'fps_max'
string cvar_fps_override,	PREFIX, 'fps_override'
string cvar_ex_interp,		PREFIX, 'ex_interp'

string szWelcomeMessage, 'flatcheat has been successfully loaded.', 10

string szAutorunFilename,	AUTORUN_FILE

string szErr_FailedToFindCvar_x,				'Failed to find cvar `%s`'
string szErr_FailToFindLimConnCvarsFuncRef,		'Failed to find LimitConnectionCvars function call reference'

string szErr_Redirect,							'%s redirection failed.', 13, 10, 'There was not exactly %d redirections (%d were made)'

string szClientSpeedMultiplier,					'Client speed multiplier'
string szClientTime,							'Client time'
string szScreenColorX,							'Screen Color (X)'

refreshFuncPatchOrigFunc db 26, 14, 5, 14, 5, 5, 0
refreshFuncPatch db 	$83, $3D, $FF, $FF, $FF, $FF, $00, $75, $41, $55, $89, $E5, $83, $EC, $14, $C7, \
						$05, $C0, $62, $6F, $04, $00, $00, $00, $00, $E8, $FF, $FF, $FF, $FF, $A1, $6C, \
						$62, $6F, $04, $85, $C0, $75, $05, $E8, $FF, $FF, $FF, $FF, $E8, $FF, $FF, $FF, \
						$FF, $A1, $6C, $62, $6F, $04, $85, $C0, $75, $0A, $E8, $FF, $FF, $FF, $FF, $E8, \
						$FF, $FF, $FF, $FF, $E8, $FF, $FF, $FF, $FF, $C9, $C3, $90
sizeof.refreshFuncPatch = $ + 1 - refreshFuncPatch
