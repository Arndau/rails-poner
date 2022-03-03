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
          html: render_to_string(partial: "messages/message_marker", locals: { user: message.user, message: message }),
          # info_window: render_to_string(partial: "info_window", locals: { politic: politic }),
          # image_url: helpers.asset_url("corruption.png")
        }
      end
    # end
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

  def itinerary
    @message_coordinates = [@message.longitude, @message.latitude]

    # Villa Gaudelet
    @user_coordinates = [2.3853767, 48.8641418] # TODO: ask user for his coordinates (via JS)
    authorize @message

    # Un peu plus haut
    # @user_coordinates = [2.4064122, 48.8759685] # TODO: ask user for his coordinates (via JS)
  end

  private

  def set_message
    @message = Message.find(params[:id])
    authorize @message
  end

end
