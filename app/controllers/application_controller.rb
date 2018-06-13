class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  helper_method :logged_in?

  def authenticate
    redirect_to '/login' unless current_user
  end
end
