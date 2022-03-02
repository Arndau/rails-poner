class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy, :show]

  def index
    @messages = policy_scope(Message)

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @messages.map do |message|
      {
        lat: message.latitude,
        lng: message.longitude
      }
    end
  end

  def show
  end 

  def new
    @message = Message.new
    authorize @message
  end

  #create --> donner infos à qui envoyer 
  #unlock

  def destroy
    @message.destroy
  end

  



  private

  def set_message
    @message = Message.find(params[:id])
    authorize @message
  end

end
