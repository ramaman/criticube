class MessagesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_conversation, :only => [:conversation, :create]

  def index

  end

  def conversation

  end

  def create

  end

  private

  def set_conversation
    @user = User.find(params[:user_id])
  end

end