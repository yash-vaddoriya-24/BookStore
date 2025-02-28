class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: "You are not allowed to do that!"
  end
  before_action :configure_permitted_parameters, if: :devise_controller?


  puts "In Application Controller"
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # protect_from_forgery with: :exception

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :remember_me)
    end
  end

  def after_sign_up_path_for(resource)
    new_user_session_path # Redirects to login page after registration
  end

  private
    def record_not_found
      render plain: "Record Not Found", status: 404
    end
end
