class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy, :show]

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



  private

  def set_message
    @message = Message.find(params[:id])
    authorize @message
  end

end
