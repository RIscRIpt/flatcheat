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
dd AO_GetScreenFadePushReference ;for Engine, ClientDLL, pPmove

dd AO_GetEngine

dd AO_GetClientDLL
dd AO_GetPlayerMove_Ptr
dd AO_GetClientDLL_Interface_Version

dd AO_GetConsoleColor
ao_getListEnd:

;Patterns:
string szScreenFade, 'ScreenFade'

;Error messages:
string szErr_GetScreenFadePushReference1,	'AO_GetScreenFacePushReference failed to find location of "ScreenFade"'
string szErr_GetScreenFadePushReference2,	'AO_GetScreenFacePushReference failed to find reference of push offset "ScreenFade"'

string szErr_GetEngine_InvalidByte,			'AO_GetEngine failed, invalid byte found at 0x0C + push "ScreenFade"'
string szErr_GetClientDLL_InvalidWord,		'AO_GetClientDLL failed, invalid byte found at 0x11 + push "ScreenFade"'
string szErr_GetPlayerMove_Ptr_IB,			'AO_GetPlayerMove_Ptr failed, invalid byte found at 0x17 + push "ScreenFade"'

string szErr_GetClientDLL_IV_ref,			'AO_GetClientDLL_Interface_Version failed to find reference of call dword ptr ClientDLL.Initialize'
string szErr_GetClientDLL_IV_notbyte,		'AO_GetClientDLL_Interface_Version found version is not byte (?)'
