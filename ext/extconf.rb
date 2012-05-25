require 'mkmf'

buildDir =  "src/build/"
buildLib =  "#{buildDir}/lib/"

ENET_INC = "-I#{buildDir}/include/ -I#{buildDir}/include/enet"
ENET_LIB = "-L#{buildLib} -lenet"

# set flags. 
$CFLAGS += " -g -Dtime_t=long " + ENET_INC
$LDFLAGS += " -static-libgcc -static-libstdc++ " + ENET_LIB

$LDFLAGS += " -lws2_32 -lwinmm" if (/mingw/ =~ RUBY_PLATFORM)

$srcs = ["interface/enet_wrap.c"]
$objs = $srcs.collect {|o| o.sub(/\.c/, ".o")}
$cleanfiles = $objs

create_makefile('ENet')
