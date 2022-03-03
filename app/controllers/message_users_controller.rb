class MessageUsersController < ApplicationController

  def index
    @user_messages = policy_scope(MessageUser)
    @markers = @user_messages.map do |user_message|
      {
        lat: user_message.message.latitude,
        lng: user_message.message.longitude,
        html: render_to_string(partial: "message_marker", locals: { user: user_message.user, user_message: user_message} ),
        # info_window: render_to_string(partial: "info_window", locals: { politic: politic }),
        # image_url: helpers.asset_url("corruption.png")
      }
    end
  end

  def update
      @message_user= MessageUser.find(params[:id])
      @message_user.unlocked = true
      @message_user.save
      authorize @message_user
  end


  def access_to_message
    @message_user= MessageUser.find(params[:id])
    authorize @message_user
    
  end

end
