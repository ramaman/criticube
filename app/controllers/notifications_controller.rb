class NotificationsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @unread_notifications = current_user.notifications.unread.order('created_at DESC').page(params[:unread_page]).per(15)
    @read_notifications = current_user.notifications.read.order('created_at DESC').page(params[:read_page]).per(15)
    respond_to :html
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.mark_as_read
    respond_to :js
  end

  def read_all
    notifications = current_user.notifications.unread
    notifications.each do |notification|
      notification.mark_as_read
    end  
    respond_to :js
  end

end