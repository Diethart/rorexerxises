class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    if @user
      set_locale
      flash[:success] = t(:success_login)
      redirect_to check_path
    else
      flash[:danger] =  t(:danger_login)
      redirect_to action: 'new'
    end
  end

  def destroy
    logout
    set_locale
    flash[:info] = t(:info_logout)
    redirect_to root_path
  end

  def set_user_locale
    session[:locale] = params[:locale]
    redirect_to :back
  end
end
