class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_notifications, if: :user_signed_in?

  private 

  def set_notifications 
    notifications = Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end
end
