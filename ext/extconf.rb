require 'mkmf'
require './LocalConfig.rb'

topDir = File.dirname(File.dirname(File.expand_path(__FILE__)))
execPlatform = LocalConfig::getExecPlatform().to_s
siteLib = topDir + "/build/lib/"
siteLibArch = siteLib + execPlatform
extlib = "../extlib"

BUILD = "#{extlib}/build"
ENET_INC = "-I#{BUILD}/include/ -I#{BUILD}/include/enet/"
ENET_LIB = "-rdynamic #{BUILD}/lib/libenet.so -Wl,-rpath,#{BUILD}/lib"
BUILD_LIB_PATH = "#{BUILD}/lib/"

if (/mingw/ =~ RUBY_PLATFORM)
  system("mkdir -p #{siteLibArch}/OIS")
else
  system("mkdir -p #{siteLibArch}/Enet")
  system("cp -a #{BUILD_LIB_PATH}/* #{siteLibArch}/Enet")
  system("cp -r #{BUILD}/include  #{topDir}/build")
end

# set flags. 
$CFLAGS += " -g -Dtime_t=long " + ENET_INC

if (/mingw/ =~ RUBY_PLATFORM)
  $LDFLAGS += " -static-libgcc -static-libstdc++ " + ENET_LIB + "-lws2_32 -lwinmm"
else
  $LDFLAGS += " -static-libgcc -static-libstdc++ " + ENET_LIB
end

Config::MAKEFILE_CONFIG["sitelibdir"] = siteLib
Config::MAKEFILE_CONFIG["sitearch"] = execPlatform


$srcs = ["interface/enet_wrap.c"]


$objs = $srcs.collect {|o| o.sub(/\.c/, ".o")}
$cleanfiles = $objs

create_makefile('ENet')
