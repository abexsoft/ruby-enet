#
# require this file directly at first line, unless you set 
# RUBYLIB and LD_LIBRARY_PATH. (check sample code)
#
require 'rbconfig'

topDir = File.dirname(File.dirname(File.expand_path(__FILE__)))

require topDir + '/ext/LocalConfig.rb'

libPath  = topDir  + "/build/lib"
extPath  = libPath + "/" + LocalConfig::getExecPlatform().to_s
ldLibPath = "#{extPath}/Enet"

# needed by dynamic library.
if (/mingw/ =~ RUBY_PLATFORM)
  if (ENV["PATH"] == nil)
    ENV["PATH"] = extPath
    exec("ruby " + $0)
  elsif (!ENV["PATH"].include?(extPath))
    ENV["PATH"] = extPath + ";" + ENV["PATH"]
    exec("ruby " + $0)
  end
else
  if (ENV["LD_LIBRARY_PATH"] == nil)
    ENV["LD_LIBRARY_PATH"] = ldLibPath
    #exec("ruby -r profile " + $0)
    exec($0, *ARGV)
  elsif (!ENV["LD_LIBRARY_PATH"].include?(extPath))
    ENV["LD_LIBRARY_PATH"] = ldLibPath + ":" + ENV["LD_LIBRARY_PATH"]
    exec($0, *ARGV)
  end
end


$LOAD_PATH.push(libPath)
$LOAD_PATH.push(extPath)
$LOAD_PATH.push("./")
