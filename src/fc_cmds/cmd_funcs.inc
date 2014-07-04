UB_COUNT = 0
macro define_ub name {
	name = UB_COUNT
	UB_COUNT = UB_COUNT + 1
}

define_ub UB_FPS_BOOST
define_ub UB_FASTRUN
define_ub UB_JUMPBUG
define_ub UB_STRAFE
define_ub UB_GROUNDSTRAFE
define_ub UB_GROUNDSTRAFE_STANDUP

align 4
userButtons dd ?

currentFrameN dd 0
showFrameN dd 0

maxFlashAlpha db ?

string szCmdExecUsage,			'Usage: ', PREFIX, 'exec "path to a script.cfg"', 13, 10

string szFmtCV_int,				'"%s" is "%i"', 13, 10

string szFmtLim_int,			'The value of "%s" should be between %i and %i', 13, 10
