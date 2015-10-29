MAKE=make
export GCCPATH=/opt/pdp11
export GCCVERSION=4.9.2
DIRS= h kernel drivers lib shell sys 

all:
	set -e; for d in $(DIRS); do $(MAKE) -C $$d ; done

clean:
	set -e; for d in $(DIRS); do $(MAKE) clean -C $$d ; done

mrproper:
	set -e; for d in $(DIRS); do $(MAKE) mrproper -C $$d ; done
