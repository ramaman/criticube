class MessagesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_conversation, :only => [:conversation]

  def index
    # @messages = Kaminari.paginate_array(current_user.fetch_conversations).page(params[:page]).per(20)
    # @unreads = current_user.unread_conversations
    @messages = Kaminari.paginate_array(current_user.fetch_conversations).page(params[:page]).per(15)
    # @messages = current_user.fetch_conversations.page(params[:page]).per(50)
    @title = "Messages (#{current_user.unread_messages_count})"
    respond_to :html #, :json
  end

  def conversation
    @messages = current_user.fetch_conversation_with(@user).page(params[:page]).per(5)
    @title = "Conversation with #{@user.first_name}"
    @reply_point = @messages[1]    
    current_user.mark_read_conversation_with(@user)
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.save

    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
  end

  private

  def set_conversation
    @user = User.find(params[:user_id])
    raise ActionController::RoutingError.new('Not Found') if current_user == @user
  end

  def message_params
    params[:message].slice(:body, :recipient_id)
  end

end