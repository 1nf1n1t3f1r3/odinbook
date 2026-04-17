class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Need to Sign Up to do anything
  before_action :authenticate_user!

  # Add Usernames
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pagy
  include Pagy::Method

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
  end
end
