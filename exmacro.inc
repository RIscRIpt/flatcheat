macro string name, data {
	name db data, 0
	sizeof.#name = $ - name
}

macro jmpcall dest, [arg] { ; push dword arguments and jump to destination
	common
    if ~ arg eq
		reverse
		pushd arg
	common
	end if
    jmp dest
}
