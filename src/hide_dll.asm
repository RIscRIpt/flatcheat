proc HideDLL ;on success CF=1, otherwise CF=0
	invoke DisableThreadLibraryCalls, [self]
	test eax, eax
	jz FatalError
	ret
endp