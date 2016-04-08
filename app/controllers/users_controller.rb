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
      set_locale
      UserNotification.welcome_email(current_user).deliver_now
      flash[:success] = t(:success_login)
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
      flash[:success] = t(:user_data_changed_success)
    else
      flash[:danger] =  t(:user_data_changer_danger)
    end
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id, :locale)
  end

end
