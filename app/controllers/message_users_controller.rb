class MessageUsersController < ApplicationController

    def update
        @message= Message.find(params[:id])
        @message_user = MessageUser.find_by(user: current_user, message: @message)
        @message_user.unlocked = true
        @message_user.save
    end



end
