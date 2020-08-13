
class RoomChannel < ApplicationCable::Channel
    # calls when a client connects to the server
    def subscribed
    #   if params[:room_id].present?
        # creates a private chat room with a unique name
        # msg = Message.all
        #stream_for msg
        stream_from "RoomChannel"
    #   end


    end



    
    # calls when a client broadcasts data
    def speak(data)
      sender = current_user
      message   = data['message']

      # Save message in database as historical data
      msg = Message.new
      msg.user_id = current_user.id 
      msg.recipient_id = data["target_user"]
      msg.content = data['message']
      puts msg
      msg.save!

      # Sends back the data in realtime using websockets
     ActionCable.server.broadcast "RoomChannel", {message: message, sender: current_user, recipient: User.find(msg.recipient_id)}

    end
    
  
  end