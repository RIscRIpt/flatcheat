;eax equ pplayer ;according to debugged info:
;Address   Hex dump          Command
;038737F6  |.  50            |PUSH EAX                  ;pplayer
;038737F7  |.  6A 03         |PUSH 3                    ;flags
;038737F9  |.  FF51 08       |CALL DWORD PTR DS:[ECX+8] ;StudioDrawPlayer
;proc StudioDrawPlayer c flags, pplayer
;	mov edi, eax
;	virtual at edi
;		.player entity_state_s
;	end virtual
;	
;	leave
;	jmp [StudioInterface.StudioDrawPlayer]
;endp
