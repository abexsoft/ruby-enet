###
## rules
#

#.SUFFIXES: .cc .o .h

all: 
	cd ./ext/interface && $(MAKE)
	cd ./ext && ruby ./extconf.rb && $(MAKE) && $(MAKE) install

clean: 
	cd ./ext/interface && $(MAKE) clean
	cd ./ext && $(MAKE) clean
