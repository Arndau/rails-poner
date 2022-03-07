class MessageUsersController < ApplicationController
  before_action :set_message_user, only: [:itinerary, :update, :access_to_message, :show]

  #définir une action au bouton locked de l'index 
  #
  def index
    @user_messages = policy_scope(MessageUser)

    if params[:locked] == "true"
      @user_messages = @user_messages.where(unlocked: false)
    end

    if params[:locked] == "false"
      @user_messages = @user_messages.where(unlocked: true)
    end
    
    
    @markers = @user_messages.map do |user_message|
      {
        lat: user_message.message.latitude,
        lng: user_message.message.longitude,
        html: render_to_string(partial: "message_marker", locals: { user: user_message.user, user_message: user_message}),
        info_window: render_to_string(partial: "info_window", locals: { user_message: user_message })
      }

    end
  end


  def itinerary
    @message_coordinates = [@message_user.message.longitude, @message_user.message.latitude]

    @markers = [
      {
        lat: @message_user.message.latitude,
        lng: @message_user.message.longitude,
        html: render_to_string(partial: "message_marker", locals: { user_message: @message_user}),
      }
    ]

    # Villa Gaudelet
    @user_coordinates = [2.3853767, 48.8641418] # TODO: ask user for his coordinates (via JS)

    # Un peu plus haut
    # @user_coordinates = [2.4064122, 48.8759685] # TODO: ask user for his coordinates (via JS)
  end


  def update
      @message_user.unlocked = true
      @message_user.save
      redirect_to message_user_path(@message_user)
  end


  def access_to_message
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'message_users/access_to_message', locals: { message_user: @message_user }, formats: [:html] }
    end

  end

  def show

  end

  private

  def set_message_user
    @message_user = MessageUser.find(params[:id])
    authorize @message_user
  end
end
