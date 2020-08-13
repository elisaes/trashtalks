class RoomsController < ApplicationController
  def show

   @recipient_id =  params[:target_user_id]
   @sender = User.find(params[:target_user_id])
   @messages = Message.includes(:user).where(user_id: current_user.id, recipient_id:@recipient_id)
   .or(Message.includes(:user).where(user_id: @recipient_id, recipient_id:current_user.id))
  end
  private

end
