class MessagesController < ApplicationController

  def index
    @messages = policy_scope(Message)
    @messages = Message.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end
end
