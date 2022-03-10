class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  def default_url_options
    { host: ENV["Poner.io"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # redirection après login vers l'index
  def after_sign_in_path_for(resource)
    message_users_path # your path
  end
end
