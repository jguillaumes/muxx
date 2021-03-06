MAKE=make
DIRS= h kernel drivers lib shell sys
include ./def.mk

all:
	set -e; for d in $(DIRS); do $(MAKE) -C $$d ; done

clean:
	set -e; for d in $(DIRS); do $(MAKE) clean -C $$d ; done

mrproper:
	set -e; for d in $(DIRS); do $(MAKE) mrproper -C $$d ; done
