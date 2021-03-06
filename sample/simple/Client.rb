require "ENet.so"

class Client
  def initialize()
    if (ENet::enet_initialize() != 0)
      puts "An error occurred while initializing ENet"
      return
    end	
  end

  def setup()
    @client = ENet::enet_host_create(nil, 1, 2, 57600 / 8, 14400 / 8)
    if (@client == nil)
      puts "An error occurred while trying to create an ENet client host."
      return
    end
  end

  def connect()
    address = ENet::ENetAddress.new
    event = ENet::ENetEvent.new

    # Connect to some.server.net:1234.
    ENet::enet_address_set_host(address, "localhost")
    address.port = 1234

    # Initiate the connection, allocating the two channels 0 and 1. 
    peer = ENet::enet_host_connect(@client, address, 2, 0)
    
    if (peer == nil)
      puts "No available peers for initiating an ENet connection."
      return
    end
    
    # Wait up to 5 seconds for the connection attempt to succeed.
    if (ENet::enet_host_service(@client, event, 5000) > 0 &&
        event.type == ENet::ENET_EVENT_TYPE_CONNECT)
        puts "Connection to localhost:1234 succeeded."
    else
      # Either the 5 seconds are up or a disconnect event was 
      # received. Reset the peer in the event the 5 seconds   
      # had run out without any significant event.            
      ENet::enet_peer_reset(peer)
      puts "Connection to local:1234 failed."
    end
  end

  def update()
    event = ENet::ENetEvent.new
    while (ENet::enet_host_service(@client, event, 1000) > 0)
      case event.type
      when ENet::ENET_EVENT_TYPE_CONNECT
        puts "A new client connected"
      when ENet::ENET_EVENT_TYPE_RECEIVE
        puts "A packet was received"
        puts "length: #{event.packet.dataLength}"
        str = ENet::getPacketData(event.packet)
        puts str

        ENet::enet_packet_destroy(event.packet);
      when ENet::ENET_EVENT_TYPE_DISCONNECT
        puts "disconected."
      end
    end
  end
end

client = Client.new
client.setup
client.connect
while(true)
	client.update
end
