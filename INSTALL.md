### How to compile all libraries.

\<topDir> means an absolute path to the top directory(here).

1. compile external libraries.
   
    > $ cd \<topDir>/extlib

       download a lastest source package from http://enet.bespin.org/download/   
       and extract the source package.

    > $ ./download.sh

       configure to make and install into ./build, but an absolute path.  

    > $ ./build.sh

2. make ruby extension libraries.

    Just make at top directory.  

    > $ cd \<topDir>  
    > $ make  

    This make compiles a ruby extension library on ext/ with extlibs which are prepared above steps.   
    And then it copies libraries from ext/ and ois/build/ to build/x86-\<arch>/.  
