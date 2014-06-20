macro define_screen_info type, name {
	SI_#name#_coord POINT
	sz#name db `name, ': '
	if type eq float
		sz#name#Data db SCREEN_INFO_FLOAT_DIGITS + 6 dup ?
	else
		display 'Unsupported screen info type: ', `type, 13, 10
		err
	end if
	db 0
}

clientSpeed dq 1000.0

chkftr FASTRUN, <fastrun_movement_angle dd ?>
chkftr FASTRUN, <fastrun_angle_diff_int dd ?>
chkftr FASTRUN, <fastrun_angle_diff_flt dd ?>

jumpbug_distance dd 2.0

define_screen_info float, HSpeed
define_screen_info float, VSpeed
define_screen_info float, Height

oHUD_Redraw_result dd ?
oCL_CreateMove_result dd ?
