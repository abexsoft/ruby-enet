
class Server
  def initialize()
    if (Enet::enet_initialize() != 0)
      puts "An error occurred while initializing ENet"
      return
    end	

    
  end

  def setup()
    address = Enet::ENetAddress.new
    address.host = Enet::ENET_HOST_ANY
    # Bind the server to port 1234. 
    address.port = 1234

    @server = Enet::enet_host_create(address, 32, 2, 0, 0)
    if (@server == nil)
      puts "An error occurred while trying to create an ENet server host."
      return
    end
  end

  def update()
    event = Enet::ENetEvent.new
    while (Enet::enet_host_service(@server, event, 1000) > 0)
      case event.type
      when Enet::ENET_EVENT_TYPE_CONNECT
        puts "A new client connected"
      when Enet::ENET_EVENT_TYPE_RECEIVE
        puts "A packet was received",
        enet_packet_destroy(event.packet);
      when Enet::ENET_EVENT_TYPE_DISCONNECT
        puts "disconected."
      end
    end
  end
end
