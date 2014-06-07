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

dd AO_GetConsoleColor

dd AO_GetRegisterVariableMallocCall
ao_getListEnd:

;Patterns:
string szClear, 'clear'
string szScreenFade, 'ScreenFade'

;Error messages:
string szErr_GetScreenFadePushReference1,	'AO_GetScreenFacePushReference failed to find location of "ScreenFade"'
string szErr_GetScreenFadePushReference2,	'AO_GetScreenFacePushReference failed to find reference of push offset "ScreenFade"'

string szErr_GetEngine_InvalidByte,			'AO_GetEngine failed, invalid byte found at 0x0C + push "ScreenFade"'
string szErr_GetClientDLL_InvalidWord,		'AO_GetClientDLL failed, invalid byte found at 0x11 + push "ScreenFade"'
string szErr_GetPlayerMove_Ptr_IB,			'AO_GetPlayerMove_Ptr failed, invalid byte found at 0x17 + push "ScreenFade"'

string szErr_GetClientDLL_IV_ref,			'AO_GetClientDLL_Interface_Version failed to find reference of call dword ptr ClientDLL.Initialize'
string szErr_GetClientDLL_IV_notbyte,		'AO_GetClientDLL_Interface_Version found version is not byte (?)'

string szErr_GetConsoleColor_CmdClear,		<'AO_GetConsoleColor couldn', "'", 't find address of command "clear"'>
string szErr_GetConsoleColor_IB,			'AO_GetConsoleColor failed, invalid byte found at 0x19 + "clear" function'
string szErr_GetConsoleColor_IW,			'AO_GetConsoleColor failed, invalid word found at {0x1A + "clear" function}'

string szErr_GetRegVarMallocCall_IB,		'AO_GetRegisterVariableMallocCall failed, invalid byte found at 0x18 + pfnRegisterVariable'
