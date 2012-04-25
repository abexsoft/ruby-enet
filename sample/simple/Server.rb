
class Server
  def initialize()
    if (ENet::enet_initialize() != 0)
      puts "An error occurred while initializing ENet"
      return
    end	

    
  end

  def setup()
    address = ENet::ENetAddress.new
    address.host = ENet::ENET_HOST_ANY
    # Bind the server to port 1234. 
    address.port = 1234

    @server = ENet::enet_host_create(address, 32, 2, 0, 0)
    if (@server == nil)
      puts "An error occurred while trying to create an ENet server host."
      return
    end
  end

  def update()
    event = ENet::ENetEvent.new
    while (ENet::enet_host_service(@server, event, 1000) > 0)
      case event.type
      when ENet::ENET_EVENT_TYPE_CONNECT
        puts "A new client connected"

        @peer = event.peer

        hostName = "\0" * 16
        ENet::enet_address_get_host_ip(@peer.address, hostName, 16)
        puts hostName

        sendString = "packet"
        packet = ENet::enet_packet_create(sendString, sendString.length + 1, ENet::ENET_PACKET_FLAG_RELIABLE)

        ENet::enet_peer_send(@peer, 0, packet);

      when ENet::ENET_EVENT_TYPE_RECEIVE
        puts "A packet was received",
        enet_packet_destroy(event.packet);
      when ENet::ENET_EVENT_TYPE_DISCONNECT
        puts "disconected."
      end
    end
  end
end
