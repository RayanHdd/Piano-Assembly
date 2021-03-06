#!/bin/bash
PATH=$PATH:.
# adding additional executable binary formats
		sudo service binfmt-support start >&- 2>&-
# To compile a NASM assembly program
		z="$1"
		k=${z%.asm}
		nasm -f win32 "${k}.asm" -o "${k}.obj"

		if [ -f "${k}.obj" ] 
        then 
			# To Link a NASM assembly program
		    ./GoLink.exe /console /entry _start /ni "${k}.obj" "libw.obj"   kernel32.dll msvcrt.dll
		else
			exit 1
		fi


# command to execute a NASM assembly program
"${k}".exe

# command to delete assembler and linker created file
#rm -i "${k}".obj
#rm -i "${k}".exe
