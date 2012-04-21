%module(directors="1") "ENet"

#define ENET_CALLBACK
#define ENET_API


%include types.i


%{
#include <enet.h>
%}

ENetPacket* enet_packet_create(const char *data, size_t size, enet_uint32 flags);

%inline %{
VALUE getPacketData(ENetPacket *packet) {
	return rb_str_new(packet->data, packet->dataLength);
}
%}


%include enet.h


%{
%}


