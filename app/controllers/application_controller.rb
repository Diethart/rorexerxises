class ApplicationController < ActionController::Base

  before_action :require_login, :set_locale

  protect_from_forgery with: :exception

  private
  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def not_authenticated
    flash[:danger] = "Сперва авторизуйтесь!"
    redirect_to login_path
  end
end
