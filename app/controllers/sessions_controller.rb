class SessionsController < ApplicationController

  before_action :redirect_if_signed_in, except: [:logout]
  before_action :authenticate, only: [:logout]

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.valid?
      session[:user_id]   = @session.user_id
      session[:user_type] = @session.user_type
      redirect_to root_url, notice: I18n.t('session.flash_message.sign_out')
    else
      render :new
    end
  end

  def logout
    session[:user_id], session[:user_type] = nil
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :is_admin)
  end

  def redirect_if_signed_in
    redirect_to root_url if signed_in?
  end

end
