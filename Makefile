all:	kernel sys h lib shell

kernel:	
	cd kernel
	make

sys:
	cd kernel
	make

h:	
	cd h
	make

lib:
	cd lib
	make

shell:
	cd shell
	make

