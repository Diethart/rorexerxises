class UsersController < ApplicationController

  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :redirect_back, only: :destroy

  def index
  end

  def new
    @user = User.new
    @http_accept_language = session[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login( user_params[:email], user_params[:password] )
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

  def destroy
    User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id, :locale)
  end

  def redirect_back
    if current_user.id == params[:id].to_i
      flash[:danger] = t(:danger_user_delete)
      redirect_to admins_path
    end
  end

end
