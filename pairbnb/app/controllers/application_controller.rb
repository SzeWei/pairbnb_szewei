class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :require_login

  def index
    current_user.articles
  end

	def url_after_denied_access_when_signed_in
    Clearance.configuration.redirect_url
  end

  def url_after_denied_access_when_signed_out
    sign_in_url
  end
  
  protect_from_forgery with: :exception

  
end

