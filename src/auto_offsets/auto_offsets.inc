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

moduleList:
hw		hl_module szhwdll
client	hl_module szclientdll
vgui2	hl_module szvgui2dll
gameui	hl_module szgameuidll
opengl	hl_module szopengl32dll
tier0	hl_module sztier0dll
moduleListEnd:

ao_getList:
dd AO_GetScreenFadePushReference	;for Engine, ClientDLL, pPmove

dd AO_GetEngine

dd AO_GetClientDLL
dd AO_GetPlayerMove_Ptr
dd AO_GetClientDLL_Interface_Version

dd AO_GetClientSpeedMultiplier

dd AO_GetConsoleColor

dd AO_GetRegisterVariableMallocCall

dd AO_GetRegisterCommandWithFlag
dd AO_GetRegCmdWithFlagMallocCall
ao_getListEnd:

;Patterns:
string szClear,								'clear'
string szScreenFade,						'ScreenFade'
string szTextureLoadMs,						'Texture load: %6.1fms', 10

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
string szAO_GetConsoleColor,				'AO_GetConsoleColor'
string szAO_GetRegisterVariableMallocCall,	'AO_GetRegisterVariableMallocCall'
string szAO_GetRegisterCommandWithFlag,		'AO_GetRegisterCommandWithFlag'
string szAO_GetRegCmdWithFlagMallocCall,	'AO_GetRegCmdWithFlagMallocCall'

string szByte,								'byte'
string szWord,								'word'
string szDword,								'dword'

string szClientDLLInitialize,				'ClientDLL.Initialize'
