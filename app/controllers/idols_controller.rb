class IdolsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :info, :entry, :confirm, :create, :thankyou]
  protect_from_forgery :only => ["confirm"]
  def index
  end

  def entry
    # 入力画面を表示
    @idol = Idol.new
    # render :action => 'entry'
  end

  def confirm
    # 入力値のチェック
    if params[:idol][:date].present?
      idol = {
        name: params[:idol][:name],
        email: params[:idol][:email],
        age: params[:idol][:age],
        school: params[:idol][:school],
        height: params[:idol][:height],
        hometown: params[:idol][:hometown],
        station: params[:idol][:station],
        production: params[:idol][:production],
        date: params[:idol][:date].join(', ')
      }
      @idol = Idol.new(idol)
    else
      idol = {
        name: params[:idol][:name],
        email: params[:idol][:email],
        age: params[:idol][:age],
        school: params[:idol][:school],
        height: params[:idol][:height],
        hometown: params[:idol][:hometown],
        station: params[:idol][:station],
        production: params[:idol][:production],
        date: params[:idol][:date]
      }
      @idol = Idol.new(idol)
      # NG。入力画面を再表示
      render :action => 'entry' if @idol.invalid?
    end
  end

  def create
    # メール送信
    @idol = Idol.new(idol_params)
    @idol.save!
    IdolMailer.idol_confirm_email(@idol).deliver

    # 完了画面を表示
    render :action => 'thankyou'
  end

  def thankyou
  end

  private
    def idol_params
      params.require(:idol).permit(:name, :email, :age, :school, :height, :hometown, :station, :production, :date)
    end
end
