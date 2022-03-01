class MessagesController < ApplicationController

  def index
    @messages = policy_scope(Message)
    @messages = Message.all
  end
end
