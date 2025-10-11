class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # Devuelve el usuario logueado (o nil si no hay)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Retorna true si hay un usuario logueado
  def logged_in?
    current_user.present?
  end

  # Protege rutas que requieren login
  def require_login
    redirect_to login_path, alert: "You must log in first" unless logged_in?
  end
end
