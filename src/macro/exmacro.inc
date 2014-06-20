macro string name, [data] {
	common
	name:
	forward
	db data
	common
	db 0
	sizeof.#name = $ - name
}

macro mov_dbl_const dst, val {
	local hi, lo
	virtual at 0
		dq val
		load hi dword from 0
		load lo dword from 4
	end virtual
	mov dword[dst], hi
	mov dword[dst + 4], lo
}

macro jmpcall dest, [arg] { ; push dword arguments and jump to destination
	common
    if ~ arg eq
		reverse
		pushd dword arg
	common
	end if
    jmp dest
}
