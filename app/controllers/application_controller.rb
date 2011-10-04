class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_admin, :current_user
  include ApplicationHelper
  include ConfigHelper

private

  def current_admin_session
    return @current_admin_session if defined?(@current_admin_session)
    @current_admin_session = AdminSession.find
  end

  def current_admin
    return @current_admin if defined?(@current_admin)
    @current_admin = current_admin_session && current_admin_session.admin
  end

  def require_admin
    unless current_admin
      store_location
      flash[:notice] = t('common.must be logged')
      redirect_to new_admin_admin_session_url
      return false
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = t('common.must be logged')
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      #redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
end
