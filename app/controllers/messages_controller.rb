class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy, :show, :itinerary]

  def index
  # PARTIE filtrer depuis l'index Message
    # if params[A TROUVER].present?
    #   sql_query = "APPUI BOUTON"
      # @messages = policy_scope(Message).where(???????)
    # else
      @messages = policy_scope(Message)
      @markers = @messages.geocoded.map do |message|
        {
          lat: message.latitude,
          lng: message.longitude,
          #html: render_to_string(partial: "message/message_marker", locals: { user: message.user, message: message }),
          # info_window: render_to_string(partial: "info_window", locals: { politic: politic }),
          # image_url: helpers.asset_url("corruption.png")
        }
      end
    # end
  end

  def show
    @sender_name = "#{message.last_name} #{message.first_name}"

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
