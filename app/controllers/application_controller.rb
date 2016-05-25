class ApplicationController < ActionController::Base
  include Pundit
  before_action :require_login, :set_locale

  protect_from_forgery with: :exception

  private
  def set_locale
    I18n.locale = current_user.try(:locale) || session[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def not_authenticated
    flash[:danger] = t(:app_login_danger)
    redirect_to login_path
  end
end
