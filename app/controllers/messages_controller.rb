class MessagesController < ApplicationController

  def index
    @messages = policy_scope(Message)

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    # @markers = @messages.geocoded.map do |message|
    #   {
    #     lat: message.latitude,
    #     lng: message.longitude
    #   }
    # end
  end
end
