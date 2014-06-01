struct hl_module
	name dd ?
	base dd ?
	size dd ?
ends

string szhwdll,		'hw.dll'
string szclientdll,	'client.dll'
string szvgui2dll,	'vgui2.dll'

moduleList:
hw		hl_module szhwdll
client	hl_module szclientdll
vgui2	hl_module szvgui2dll
moduleListEnd:

ao_getList:
dd AO_GetScreenFadePushReference	;for Engine, ClientDLL, pPmove

dd AO_GetEngine

dd AO_GetCommandListBase
dd AO_GetConsoleColor				;must be after AO_GetCommandListBase

dd AO_GetClientDLL
dd AO_GetPlayerMove_Ptr
dd AO_GetClientDLL_Interface_Version
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

string szErr_GetCmdListBase_IB1,			'AO_GetCommandListBase failed, invalid byte found at 0x19 + [Engine.pfnAddCommand]'
string szErr_GetCmdListBase_IB2,			'AO_GetCommandListBase failed, invalid byte found at 0x12 + [0x1A + [Engine.pfnAddCommand]]'
string szErr_GetCmdListBase_IW,				'AO_GetCommandListBase failed, invalid word found at 0x2E + [0x13 + [0x1A + [Engine.pfnAddCommand]]]'

string szErr_GetConsoleColor_CmdClear,		<'AO_GetConsoleColor couldn', "'", 't find address of command "clear"'>
string szErr_GetConsoleColor_IB,			'AO_GetConsoleColor failed, invalid byte found at 0x19 + "clear" function'
string szErr_GetConsoleColor_IW,			'AO_GetConsoleColor failed, invalid word found at {0x1A + "clear" function}'
