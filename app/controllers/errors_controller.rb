# エラー発生時の404, 500エラーページを表示させるコントローラ
class ErrorsController < ActionController::Base
  layout 'application'

  # rescue_fromは下から評価される
  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  # 404エラー画面を表示
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: "errors/error_404", status: 404, layout: 'application'
  end

  # 500エラー画面を表示
  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: "errors/error_500", status: 500, layout: 'application'
  end

  def show
    raise env['action_dispatch.exception']
  end
end
