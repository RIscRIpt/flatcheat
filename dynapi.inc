dynapiList:
dd LDAPI_GetModuleInformation
dynapiListEnd:

hKernel32 dd ?
GetModuleInformation dd ?

string szKernel32DLL, 'kernel32.dll'
string szGetModuleInformation, 'GetModuleInformation'
string szK32GetModuleInformation, 'K32GetModuleInformation'