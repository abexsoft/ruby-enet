class LocalConfig

def self.getExecPlatform
  platform = Gem::Platform.new(Gem::Platform::CURRENT)
  case platform.os
  when /mswin/, /mingw/
    platform.os = "msvcrt"
  end
  return platform
end

end
