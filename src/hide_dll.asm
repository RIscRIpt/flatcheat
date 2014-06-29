proc HideDLL
	invoke DisableThreadLibraryCalls, [self]
	test eax, eax
	jz FatalError
	ret
endp
