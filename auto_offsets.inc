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
dd AO_GetEngine
dd AO_GetClientDLL
dd AO_GetClientDLL_Interface_Version
ao_getListEnd:

;Patterns:
string szScreenFade, 'ScreenFade'

;Error messages:
string szErr_GetEngine_screenfade,		'AO_GetEngine failed to find "ScreenFade" location'
string szErr_GetEngine_ref,				'AO_GetEngine failed to find reference of push dword addr of "ScreenFade"'

string szErr_GetClientDLL_screenfade,	'AO_GetClientDLL failed to find "ScreenFade" location'
string szErr_GetClientDLL_ref,			'AO_GetClientDLL failed to find reference of push dword addr of "ScreenFade"'

string szErr_GetClientDLL_IV_ref,		'AO_GetClientDLL_Interface_Version failed to find reference of call dword ptr ClientDLL.Initialize'
string szErr_GetClientDLL_IV_notbyte,	'AO_GetClientDLL_Interface_Version found version is not byte (?)'
