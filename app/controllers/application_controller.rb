class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def authenticate
    return if signed_in?
    redirect_to new_session_url, alert: I18n.t('session.flash_message.sign_in')
  end

  def current_user
    @current_user ||= begin
      user_klass = ApplicationRecord.const_get(session[:user_type].to_s.classify)
      user_klass.find(session[:user_id])
    end
  rescue NameError, ActiveRecord::RecordNotFound => ex
    NullUser.new
  end

  def signed_in?
    current_user.present?
  end

  def record_not_found(exception)
    @klass = exception.class
    render 'errors/not_found', layout: false
  end

  helper_method :current_user
  helper_method :signed_in?
end
