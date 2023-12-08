class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?  
  before_action :set_tags
  include Pundit::Authorization
  after_action :verify_authorized, except: [ :index ], unless: :skip_pundit?
  after_action :verify_policy_scoped, only:  [ :index ], unless: :skip_pundit?
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActionController::Redirecting::UnsafeRedirectError do
    redirect_to root_url
  end

  private

  def set_tags
    set_meta_tags title: "Your portfolio",
                  description: "A space to showcase your work and your ideas",
                  keywords: "portfolio, ideas, projects, showcase, work, blog, article"
  end

  def configure_permitted_parameters
    attributes = [:full_name, :email, :password, :password_confirmation, :bio]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
  
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
