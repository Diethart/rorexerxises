class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = login_from(provider)
    if @user
      flash[:info] = t(:oauths_login, provider: provider.titleize)
      redirect_to root_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        flash[:info] = t(:oauths_login, provider: provider.titleize)
        redirect_to root_path
      rescue
        flash[:danger] = t(:oauths_danger, provider: provider.titleize)
        redirect_to root_path
      end
    end
  end

  private
   def auth_params
     params.permit(:code, :provider)
   end
end
