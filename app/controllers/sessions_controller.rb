class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    if @user
      flash[:success] = t(:success_login)
      redirect_to check_path
    else
      flash[:danger] =  t(:danger_login)
      redirect_to action: 'new'
    end
  end

  def destroy
    tmp = current_user.locale
    logout
    session[:locale] = tmp
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
