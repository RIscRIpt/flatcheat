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

unicodeBuffer dw 256 dup 0
sizeof.unicodeBuffer = $ - unicodeBuffer



wcsFmtPath du '%s\%s', 0
wcsScriptPath dw MAX_PATH + 1 dup ?

string szCmdExecUsage,			'Usage: ', PREFIX, 'exec "path to a script.cfg"', 13, 10
