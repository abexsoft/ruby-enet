%module(directors="1") "Enet"

#define ENET_CALLBACK
#define ENET_API


%include types.i


%{
#include <enet.h>
%}

%include enet.h

%{
%}

//%include OIS_Prereqs.i

