class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    if session[:email]
      @current_user ||= User.find_by(email: session[:email])
    else
      @current_user = nil
    end
  end

end
