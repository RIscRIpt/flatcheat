proc pfnHookEvent szName, pfnEvent
	;cinvoke Engine.pfnHookEvent, [szName], [pfnEvent]
	;ret
	jmp [Engine.pfnHookEvent]
endp

proc pfnHookUserMsg szMsgName, pfnUserMsg
	;cinvoke Engine.pfnHookUserMsg, [szMsgName], [pfnUserMsg]
	;ret
	jmp [Engine.pfnHookUserMsg]
endp

proc pfnAddCommand szCmdName, function
	xor eax, eax
	ret
endp

proc pfnRegisterVariable szName, szValue, flags
	cinvoke Engine.pfnGetCvarPointer, [szName]
	test eax, eax
	jnz .ret
	;cinvoke Engine.pfnRegisterVariable, [szName], [szValue], [flags]
	jmp [Engine.pfnRegisterVariable]
	.ret:
	ret
endp