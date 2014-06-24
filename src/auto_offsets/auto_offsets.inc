struct hl_module
	name dd ?
	base dd ?
	size dd ?
ends

string szhwdll,			'hw.dll'
string szclientdll,		'client.dll'
string szvgui2dll,		'vgui2.dll'
string szgameuidll,		'GameUI.dll'
string szopengl32dll,	'OPENGL32.dll'
string sztier0dll,		'tier0.dll'
string szvstdlibdll,	'vstdlib.dll'

moduleList:
hw		hl_module szhwdll
client	hl_module szclientdll
vgui2	hl_module szvgui2dll
gameui	hl_module szgameuidll
opengl	hl_module szopengl32dll
tier0	hl_module sztier0dll
vstdlib	hl_module szvstdlibdll
moduleListEnd:

ao_getList:
dd AO_GetScreenFadePushReference	;for Engine, ClientDLL, pPmove

dd AO_GetEngine

dd AO_GetClientDLL
dd AO_GetPlayerMove_Ptr
dd AO_GetClientDLL_Interface_Version

dd AO_GetClientSpeedMultiplier

dd AO_GetPushHGSMIReference
dd AO_GetEngineStudio
dd AO_GetStudioModelInterface

dd AO_GetConsoleColor

dd AO_GetRegisterVariableMallocCall

dd AO_GetRegisterCommandWithFlag
dd AO_GetRegCmdWithFlagMallocCall

dd AO_GetRefreshFunc
dd AO_GetRefreshFuncOrigAddessess

dd AO_GetFuncLimitConnectionCvars
ao_getListEnd:

;Patterns:
string szClear,								'clear'
string szScreenFade,						'ScreenFade'
string szTextureLoadMs,						'Texture load: %6.1fms', 10
string szErrMsgCouldntGetStudioModelRI,		"Couldn't get client .dll studio model rendering interface."
string szr_norefresh,						'r_norefresh'
string bpClearFunction, $55, $8B, $EC, $83, $EC, $14, $D9, $05, $FF, $FF, $FF, $FF, $D8, $1D, $FF, $FF, $FF, $FF, $DF, $E0, $F6, $C4, $44, $0F, $8A
string szcl_updatereate_min,				'cl_updaterate minimum is %f'

;Offsets:
offOrigClearFunctions db 0x7B, 0x0E, 0x05, 0x0E, 0x05, 0x05, 0x00

;Error messages:
string szErr_s_Failed_Invalid_x_at_x_x,		'%s failed, invalid %s:%X found at %08X (should be %X)'
string szErr_s_FailedToFindXOf_s,			'%s failed to find %s of %s'

string szReference,							'reference'
string szLocation,							'location'

string szAO_GetScreenFadePushReference,		'AO_GetScreenFadePushReference'
string szAO_GetEngine,						'AO_GetEngine'
string szAO_GetClientDLL,					'AO_GetClientDLL'
string szAO_GetPlayerMove_Ptr,				'AO_GetPlayerMove_Ptr'
string szAO_GetClientDLL_Interface_Version,	'AO_GetClientDLL_Interface_Version'
string szAO_GetClientSpeedMultiplier,		'AO_GetClientSpeedMultiplier'
string szAO_GetPushHGSMIReference,			'AO_GetPushHGSMIReference'
string szAO_GetEngineStudio,				'AO_GetEngineStudio'
string szAO_GetStudioModelInterface,		'AO_GetStudioModelInterface'
string szAO_GetConsoleColor,				'AO_GetConsoleColor'
string szAO_GetRegisterVariableMallocCall,	'AO_GetRegisterVariableMallocCall'
string szAO_GetRegisterCommandWithFlag,		'AO_GetRegisterCommandWithFlag'
string szAO_GetRegCmdWithFlagMallocCall,	'AO_GetRegCmdWithFlagMallocCall'
string szAO_GetRefreshFunc,					'AO_GetRefreshFunc'
string szAO_GetRefreshFuncOrigAddessess,	'AO_GetRefreshFuncOrigAddessess'
string szAO_GetFuncLimitConnectionCvars,	'AO_GetFuncLimitConnectionCvars'

string szByte,								'byte'
string szWord,								'word'
string szDword,								'dword'

string szClientDLLInitialize,				'ClientDLL.Initialize'
