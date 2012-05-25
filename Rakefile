require 'rubygems/package_task'
require 'rake/clean'

ENET_VER="1.3.3"
#
# Download ENet sources.
#
desc 'Download the enet source package.'
task :download do
  chdir('ext/src') {
    sh "wget http://enet.bespin.org/download/enet-#{ENET_VER}.tar.gz"
    sh "tar xzvf enet-#{ENET_VER}.tar.gz"
  }
end

#
# Compile ENet libraries.
#
desc 'Compile the enet libraries.'
task :compile do
  chdir("ext/src/enet-#{ENET_VER}/") {
    sh "./configure --prefix=$PWD/../build --enable-shared=no"
    sh "make && make install"
  }
end

#
# Extension
#

DLEXT = RbConfig::MAKEFILE_CONFIG['DLEXT']

desc 'Build the enet extension'
task :build => "lib/ENet.#{DLEXT}"

file "lib/ENet.#{DLEXT}" => "ext/ENet.#{DLEXT}" do |f|
  cp f.prerequisites, "lib/", :preserve => true
end

file "ext/ENet.#{DLEXT}" => FileList["ext/Makefile"] do |f|
  sh 'cd ext && make clean && make'
end
CLEAN.include 'ext/*.{o,so,dll}'

file 'ext/Makefile' => FileList['ext/interface/enet_wrap.cpp'] do
  chdir('ext') { ruby 'extconf.rb' }
end
CLEAN.include 'ext/Makefile'

file 'ext/interface/enet_wrap.cpp' do
  chdir('ext/interface') { sh 'make' }
end
CLEAN.include 'ext/interface/enet_wrap.{cpp,h,o}'

#
# Document
#
desc 'Create documents'
task :doc => 'ext/interface/enet_wrap.cpp' do
  sh 'rdoc ext/interface/enet_wrap.cpp'
end

#
# Gemspec
#
spec = Gem::Specification.new do |s|

  s.name        = "ruby-enet"
  s.version     = "0.0.1"
  s.summary     = "A ruby wrapper of ENet."
  s.homepage    = "https://github.com/abexsoft/ruby-enet"
  s.authors     = ["abexsoft works"]
  s.email       = ["abexsoft@gmail.com"]
  s.description = "A ruby wrapper of ENet."
  s.platform    = Gem::Platform::CURRENT
 
  # The list of files to be contained in the gem 
  s.files = FileList['Rakefile',
                     'README.md',
                     'lib/ENet.so',
                     'ext/extconf.rb',
                     'ext/interface/*.i',
                     'ext/interface/Makefile',
                    ].to_a

  s.require_paths = ["lib"]
  s.rubyforge_project = s.name
end

Gem::PackageTask.new(spec) do |pkg|
end
