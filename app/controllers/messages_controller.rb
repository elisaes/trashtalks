class MessagesController < ApplicationController
  # before_action :logged_in_user
  # before_action :get_messages
  # def index
  #   message = current_user.messages.build(message_params)
  # end
  # if message.save
  #   redirect_to messages_url
  # else
  #   render 'index'
  # end

  # def create
  # end

  # private

  #   def get_messages
  #     @messages = Message.for_display
  #     @message  = current_user.messages.build
  #   end

  #   def message_params
  #     params.require(:message).permit(:content)
  #   end
end
