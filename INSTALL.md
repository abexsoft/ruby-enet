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
    > $ ./copylib   
    > $ make  

    "copylib" copy libraries which are compiled above steps to build/lib/x86-\<arch>/.   
    This "make" compiles a ruby extension library on ext/ using build/lib/x86-\<arch>/.   
    And then it copies libraries from ext/ to x86-\<arch>/.  