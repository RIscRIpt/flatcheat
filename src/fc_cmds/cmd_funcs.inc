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

userButtons dd ?

currentFrameN dd 0
showFrameN dd 0

string szCmdExecUsage,			'Usage: ', PREFIX, 'exec "path to a script.cfg"', 13, 10
