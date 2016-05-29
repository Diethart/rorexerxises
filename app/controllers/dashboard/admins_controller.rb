class Dashboard::AdminsController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :not_allowed
  def index
    @users = User.all
    authorize :admins, :index?
  end

  private

  def not_allowed
    flash[:danger] = t(:not_allowed)
    redirect_to root_path
  end

end
