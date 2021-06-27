# NAME: Vaibhav Saxena
# ROLL NO: 2019342

main: run

# Running the Bootable Binary using QEMU	
run: compile
	qemu-system-i386 -fda Q1_2019342.bin
	
# Compiling using NASM and creating Bootable Binary	
compile:
	nasm Q1_2019342.asm -f bin -o Q1_2019342.bin
