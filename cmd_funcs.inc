UB_COUNT = 0
macro define_ub name {
	name = UB_COUNT
	UB_COUNT = UB_COUNT + 1
}

define_ub UB_FASTRUN
define_ub UB_JUMPBUG
define_ub UB_STRAFE
define_ub UB_GROUNDSTRAFE

userButtons dd ?
