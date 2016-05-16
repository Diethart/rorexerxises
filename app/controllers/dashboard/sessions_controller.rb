class Dashboard::SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def destroy
    logout
    flash[:info] = t(:info_logout)
    redirect_to root_path
  end

  def set_user_locale
    if current_user
      User.find(current_user.id).update(locale: params[:locale])
    else
      session[:locale] = params[:locale]
    end
    redirect_to :back
  end
end
