class ContestantImageController < ApplicationController
  before_filter :require_contestant_login, only: [:new, :create, :edit, :destroy]

  def new
    @contestant_image = ContestantImage.new
  end

  def create
    @contestant_image = ContestantImage.new(contestant_image_params)
    @contestant_image.user_id = current_user.id
    if ContestantImage.where(user_id: current_user.id).count > Settings.contestant_image_max
      @contestant_image.errors[:base] << "登録されている写真の数が上限を超えています。写真を削除してから再度お試し下さい。"
      render 'new'
    else
      flash.now.alert = "登録に成功しました！写真が承認され次第マイページに反映されますのでしばらくお待ち下さい！" if @contestant_image.save
      render 'new'
    end
  end

  def edit
    @contestant_images = ContestantImage.where(user_id: current_user.id)
  end

  def destroy
    ContestantImage.transaction do
      params[:delete_images].each do |delete_image|
        if ContestantImage.find(delete_image[:id]).present? && delete_image[:delete]
          ContestantImage.find(delete_image[:id]).destroy!
        end
      end
    end
    flash.now[:success] = "選択された画像を削除しました。"
    @contestant_images = ContestantImage.where(user_id: current_user.id)
    render 'edit'
  rescue => e
    @contestant_images = ContestantImage.where(user_id: current_user.id)
    # flash.now.alert = "削除に失敗しました。時間を置いて再度お試しください。"
    flash.now.alert = e.message
    render 'edit'
  end

  def contestant_image_params
    params.require(:contestant_image).permit(:profile_image,
                                             :profile_image_crop_param_x,
                                             :profile_image_crop_param_y,
                                             :profile_image_crop_param_height,
                                             :profile_image_crop_param_width
                                            )
  end
end
