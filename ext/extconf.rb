require 'mkmf'
require '../tool/LocalConfig.rb'

topDir = File.dirname(File.dirname(File.expand_path(__FILE__)))
execPlatform = LocalConfig::getExecPlatform().to_s

buildDir =    "#{topDir}/build/"
siteLib =     "#{buildDir}/lib/"
siteLibArch = "#{siteLib}/#{execPlatform}"

ENET_INC = "-I#{buildDir}/include/ -I#{buildDir}/include/enet"
ENET_LIB = "-rdynamic #{siteLibArch}/libenet.so -Wl,-rpath,.lib/#{execPlatform}"

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
