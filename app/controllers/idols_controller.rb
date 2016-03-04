class IdolsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :info, :entry, :confirm, :thankyou]
  def index
  end

  def entry
    # 入力画面を表示
    @idol = Idol.new
    # render :action => 'entry'
  end

  def confirm
    # 入力値のチェック
    @idol = Idol.new(idol_params)
    unless @idol.valid?
      render :action => 'entry'
    end
  end



  def thankyou
    # メール送信
    # @idol = Idol.create(
    #   name: params[:idol][:name],
    #   age: params[:idol][:age],
    #   school: params[:idol][:school],
    #   height: params[:idol][:height],
    #   hometown: params[:idol][:hometown],
    #   station: params[:idol][:station],
    #   email: params[:idol][:email],
    #   date: params[:idol][:date]
    # )
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
    binding.pry
    idol.save
    IdolMailer.idol_confirm_email(idol).deliver

    # 完了画面を表示
    render :action => 'thankyou'
  end

  private
    def idol_params
      binding.pry
      # params_date_values = []
      # params[:idol][:date].each do |date|
      #   params_date_values << date.to_i
      # end
      # params[:idol].store(:date, params_date_values)
      params.require(:idol).permit(:name, :age, :school, :height, :hometown, :station, :email, :production, :date)
    end

end
