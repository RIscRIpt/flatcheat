if SCREEN_INFO_FLOAT_DIGITS > 0 & SCREEN_INFO_FLOAT_DIGITS < 16
	szFmtDouble db '%-5.'
	if SCREEN_INFO_FLOAT_DIGITS > 9
		SCREEN_INFO_FLOAT_DIGITS = SCREEN_INFO_FLOAT_DIGITS / 10
		db '1', ('0' + SCREEN_INFO_FLOAT_DIGITS)
	else
		db ('0' + SCREEN_INFO_FLOAT_DIGITS)
	end if
	db 'f', 0
else
	display 'Error, invalid SCREEN_INFO_FLOAT_DIGITS value: ', d=SCREEN_INFO_FLOAT_DIGITS, 13, 10
	err
end if

align 4
flPOne dd 1.0
flMOne dd -1.0
flScreenCenter vec2_s
screenCoord vec2_s
