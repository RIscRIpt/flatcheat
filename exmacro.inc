macro string name, data {
	name db data, 0
	sizeof.#name = $ - name
}

;macro struct_list list_name, struct_type, [structs] {
;	common
;	list_name:
;	
;	...
;	
;	common
;	list_name#End:
;}