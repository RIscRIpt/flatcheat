;http://wasm.ru/forum/viewtopic.php?pid=520153
;from l_inc
;Displays a binary representation of a number
macro dispBin num*, padding, leader, trailer, size
{
	local digCount,number,lastdig
	number = size num
	lastdig = number

	if number < 0
		display '-'
		number = -(number shr 1 + number and 1)
		lastdig = -(lastdig + number + number)
	else
		number = number shr 1
		lastdig = lastdig and 1
	end if
	digCount = 0
	while number shr digCount > 0
		digCount = digCount + 1
	end while
	if ~ leader eq
		display leader
	end if
	if ~ padding eq
		if digCount < padding
			times (padding-digCount-1) display '0'
		end if
	end if
	times digCount display number shr (digCount-%) and 1+'0'
	display lastdig+'0'
	if ~ trailer eq
		display trailer
	end if
}

;Displays a decimal representation of a number
macro dispDec num*, padding, leader, trailer
{
	local digCount,tenPow,number,lastdig
	number = num
	lastdig = number
	
	if number < 0
		display '-'
		number = (-(number shr 1 + number and 1)) / 5
		lastdig = -(lastdig + number*5 + number*5)
	else
		number = number/10
		lastdig = lastdig mod 10
	end if
	digCount = 0
	tenPow = 1
	while tenPow <= number
		tenPow = tenPow*10
		digCount = digCount + 1
	end while
	if ~ leader eq
		display leader
	end if
	if ~ padding eq
		if digCount < padding
			times (padding-digCount-1) display '0'
		end if
	end if
	repeat digCount
		tenPow = tenPow/10
		display number/tenPow+'0'
		number = number mod tenPow
	end repeat
	display lastdig+'0'
	if ~ trailer eq
		display trailer
	end if
}

;Displays a hexadecimal representation of a number
macro dispHex num*, padding, leader, trailer, size
{
	local digCount,dig,number,lastdig
	number = size num
	lastdig = number
	
	if number < 0
		display '-'
		number = (-(number shr 1 + number and 1)) shr 3
		lastdig = -(lastdig + number shl 3 + number shl 3)
	else
		number = number shr 4
		lastdig = lastdig and 0xF
	end if
	digCount = 0
	while number shr (digCount*4) > 0
		digCount = digCount + 1
	end while
	if ~ leader eq
		display leader
	end if
	if ~ padding eq
		if digCount < padding
			times (padding-digCount-1) display '0'
		end if
	end if
	repeat digCount
		dig = number shr ((digCount-%)*4) and 0Fh
		if dig > 9
			dig = dig-'0'+('A'-10)
		end if
		display dig+'0'
	end repeat
	if lastdig > 9
		lastdig = lastdig-'0'+('A'-10)
	end if
	display lastdig+'0'
	if ~ trailer eq
		display trailer
	end if
}

;Displays a string with binary, decimal and hexadecimal values
;usage: display d=number,":",9,b=number,9,h=number,13,10
macro display [token]
{
	forward
		define matched +
		define matched -
		irp type, =b, =d, =h, =bb, =bw, =bd, =bq, =hb, =hw, =hd, =hq \{ match type==n,token \\{ restore matched \\} \}
		match =b==number,token \{ dispBin number,,,'b' \}
		match =d==number,token \{ dispDec number \}
		match =h==number,token \{ dispHex number,,'0x' \}
		match =bb==number,token \{ dispBin number,,,'b',byte \}
		match =bw==number,token \{ dispBin number,,,'b',word \}
		match =bd==number,token \{ dispBin number,,,'b',dword \}
		match =bq==number,token \{ dispBin number,,,'b',qword \}
		match =hb==number,token \{ dispHex number,,'0x',,byte \}
		match =hw==number,token \{ dispHex number,,'0x',,word \}
		match =hd==number,token \{ dispHex number,,'0x',,dword \}
		match =hq==number,token \{ dispHex number,,'0x',,qword \}
		match -,matched \{ display token \}
		match -,matched \{ restore matched \}
		restore matched
}