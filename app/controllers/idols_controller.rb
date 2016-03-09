class IdolsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :info, :entry, :confirm, :create, :thankyou]
  def index
  end

  def entry
    # 入力画面を表示
    @idol = Idol.new
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
      render action: 'entry' if @idol.invalid?
    end
  end

  def create
    # メール送信
    idol = Idol.new
    idol.name = params[:idol][:name]
    idol.age = params[:idol][:age]
    idol.school = params[:idol][:school]
    idol.height = params[:idol][:height]
    idol.hometown = params[:idol][:hometown]
    idol.station = params[:idol][:station]
    idol.email = params[:idol][:email]
    idol.production = params[:idol][:production]
    idol.date = params[:idol][:date]
    idol.save
    IdolMailer.idol_confirm_email(idol).deliver
    IdolMailer.idol_confirm_admin_email(idol).deliver
    # 完了画面を表示
    render action: 'thankyou'
  end

  def thankyou
  end
end
