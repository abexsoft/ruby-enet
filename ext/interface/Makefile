.PHONY: clean

SWIG = swig
SWIGFLAGS = -ruby -I../src/build/include/enet
RUBY = ruby

TARGET = enet_wrap.c

all: $(TARGET)

$(TARGET): enet.i
	$(SWIG) $(SWIGFLAGS) -o $@ $<

clean:
	@rm -f $(TARGET)
