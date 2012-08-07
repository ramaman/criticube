class MessagesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_conversation, :only => [:conversation, :create]

  def index
    # @messages = Kaminari.paginate_array(current_user.fetch_conversations).page(params[:page]).per(20)
    # @unreads = current_user.unread_conversations
    @messages = current_user.fetch_conversations.page(params[:page]).per(50)

    respond_to :html#, :json
  end

  def conversation

    respond_to :html
  end

  def create

    respond_to :html
  end

  private

  def set_conversation
    @user = User.find(params[:user_id])
  end

end