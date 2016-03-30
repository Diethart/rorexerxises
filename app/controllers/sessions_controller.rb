class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password])
      flash[:success] = 'Вы зашли в систему!'
      redirect_to check_path
    else
      flash[:danger] = 'Неверный e-mail или пароль'
      redirect_to action: 'new'
    end
  end

  def destroy
    logout
    flash[:info] = 'Logged out!'
    redirect_to root_path
  end
end
