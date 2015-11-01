class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # sorceryのメソッドをオーバライドしています
  def not_authenticated
    render 'errors/error_404', status: 404
  end

  def require_contestant_login
    if !logged_in? || current_user.user_type != Settings.user_type.contestant
      session[:return_to_url] = request.url if Config.save_return_to_url && request.get?
      send(Config.not_authenticated_action)
    end
  end

  def not_found
    raise ActionController::RoutingError.new('404 Not Found')
  end
end
