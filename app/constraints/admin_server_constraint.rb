# 管理サーバからのアクセスのみに制限するConstraint(ローカルホスト含む
class AdminServerConstraint
  ADMIN_IP_LIST = %w(192.168.1.1 127.0.0.1)
  
  def self.matches?(request)
    ADMIN_IP_LIST.include?(request.remote_ip)
  end
end
