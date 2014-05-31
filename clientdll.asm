;cmd equ esi ;according to debugged info:
;8D3495 682B9C04      LEA ESI,[EDX*4+hw.49C2B68] | ESI = 049C32D4 (var)
;in CL_CreateMove 2nd arg (esp + 8) = 049C32D4 (var)
;=> ESI = cmd (usercmd_s)

proc CL_CreateMove c frametime, _cmd, active
	cinvoke ClientDLL.CL_CreateMove, [frametime], [_cmd], [active]
	push eax
	
	virtual at esi
		cmd usercmd_s
	end virtual
	
	pop eax
	ret
endp
