class ApplicationController < ActionController::Base
  # include Pundit::Authorization
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  #
  # def admin_authenticate
  #   authorize current_user, :admin?
  # end
  #
  # private
  #
  # def user_not_authorized
  #   flash[:notice] = "Sorry, You Are Not Authorized To Do This"
  #   redirect_to(request.referrer || root_path)
  # end
end
