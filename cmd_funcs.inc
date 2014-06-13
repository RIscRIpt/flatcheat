UB_COUNT = 0

macro define_ub name {
	name = UB_COUNT
	UB_COUNT = UB_COUNT + 1
}

define_ub UB_JUMPBUG

userButtons dd ?

string szSpeedValue, '"', PREFIX, 'speed" is "%lf"', 10
