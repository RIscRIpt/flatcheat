macro define_screen_info type, name, display_name {
	SI_#name#_coord POINT
	sz#name db display_name, ': '
	if type eq float
		sz#name#Data db SCREEN_INFO_FLOAT_DIGITS + 6 dup ?
	else
		display 'Unsupported screen info type: ', `type, 13, 10
		err
	end if
	db 0
}

align 16
clientSpeed dq 1000.0
screenColor pcolor32_s

chkftr FASTRUN, <fastrun_movement_angle dd ?>
chkftr FASTRUN, <fastrun_angle_diff_int dd ?>
chkftr FASTRUN, <fastrun_angle_diff_flt dd ?>

jumpbug_distance dd 2.0

chkftr SI_FLASHED, <define_screen_info float, MAX_FLASHED, 'Flashed'>

chkftr SI_KZ_HSPEED, <define_screen_info float, KZ_HSpeed, 'HSpeed'>
chkftr SI_KZ_VSPEED, <define_screen_info float, KZ_VSpeed, 'VSpeed'>
chkftr SI_KZ_HEIGHT, <define_screen_info float, KZ_Height, 'Height'>

oHUD_Redraw_result dd ?
oCL_CreateMove_result dd ?
oHUD_AddEntity_result dd ?

floatOne dd 1.0
float1000 dd 1000.0
float255_to_percent dd 0.3921569
