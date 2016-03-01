class IdolsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :info, :entry, :confirm, :thankyou]
  def index
  end

  def entry
    # 入力画面を表示
    # render :action => 'entry'
    @idol = Idol.new
  end

  def confirm
    # 入力値のチェック
    @idol = Idol.new(params[:idol])
    if @idol.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end



  def thankyou
    # メール送信
    @idol = Idol.new(params[:idol])
    IdolMailer.received_email(@idol).deliver

    # 完了画面を表示
    render :action => 'thanks'
  end
end
