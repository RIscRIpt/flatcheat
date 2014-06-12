proc Command_speed
	cinvoke Engine.Cmd_Argc
	cmp eax, 1
	jne .set
	.get:
		cinvoke Engine.Con_Printf, szSpeedValue, dword[clientSpeed], dword[clientSpeed + 4]
		ret
	.set:
		cinvoke Engine.Cmd_Argv, 1
		cinvoke atof, eax
		fstp qword[clientSpeed]
		ret
endp
