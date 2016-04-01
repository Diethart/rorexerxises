class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login( user_params[:email], user_params[:password] )
      flash[:success] = 'Вы вошли в систему!'
      redirect_to cards_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Ваши данные изменены!"
    else
      flash[:danger] = "Где-то ошибка..."
    end
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id)
  end

end
