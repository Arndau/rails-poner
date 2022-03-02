class MessageUsersController < ApplicationController

  def index
    @user_messages = policy_scope(MessageUser)
    @markers = @user_messages.geocoded.map do |user_message|
      {
        lat: user_message.message.latitude,
        lng: user_message.message.longitude,
        html: render_to_string(partial: "messages/message_marker", locals: { user: user_message.user, user_message: user_message}),
        # info_window: render_to_string(partial: "info_window", locals: { politic: politic }),
        # image_url: helpers.asset_url("corruption.png")
      }
    end
  end
end
