class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # 管理画面ではDeviseの認証機能を用いるのでスキップ
  before_filter :require_login unless ENV['IS_ADMIN_WEB'] == 'true'

  private

  # sorceryのメソッドをオーバライドしています
  def not_authenticated
    redirect_to login_path, flash: { alert: 'ログインが必要です' }
  end

  def require_not_login
    return unless logged_in?
    redirect_to root_path
  end

  def restrict_contestant_login
    redirect_to root_path if current_user && current_user.user_type == Settings.user_type.contestant
  end

  def require_contestant_login
    require_specific_user_login(Settings.user_type[:contestant])
  end
  
  def require_voter_login
    require_specific_user_login(Settings.user_type[:normal])
  end

  def not_found
    raise ActionController::RoutingError.new('404 Not Found')
  end

  private

  def require_specific_user_login(user_type)
    if !logged_in? || current_user.user_type != user_type
      session[:return_to_url] = request.url if Config.save_return_to_url && request.get?
      send(Config.not_authenticated_action)
    end
  end
end
