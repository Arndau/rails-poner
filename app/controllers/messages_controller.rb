class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy, :show, :itinerary]

  def index
    @messages = policy_scope(Message)
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    # @markers = @flats.geocoded.map do |flat|
    #   {
    #     lat: flat.latitude,
    #     lng: flat.longitude
    #   }
    # end
  end

  def show
  end

  def new
    @message = Message.new
    authorize @message
  end

  def destroy
    @message.destroy
  end

  def itinerary
    @message_coordinates = [@message.longitude, @message.latitude]

    # Villa Gaudelet
    @user_coordinates = [2.3853767, 48.8641418] # TODO: ask user for his coordinates (via JS)

    # Un peu plus haut
    # @user_coordinates = [2.4064122, 48.8759685] # TODO: ask user for his coordinates (via JS)
  end

  private

  def set_message
    @message = Message.find(params[:id])
    authorize @message
  end

end
