class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

end
private
def admin?
  # @current_user = User.find_by_id(session[:current_user_id])
  # @current_user.admin == '1'
end