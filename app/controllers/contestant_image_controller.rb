class ContestantImageController < ApplicationController
  before_filter :require_contestant_login, only: [:new, :create, :edit, :destroy]

  def new
    @contestant_image = ContestantImage.new
  end

  def create
    @contestant_image = ContestantImage.new(contestant_image_params)
    @contestant_image.user_id = current_user.id
    flash.now.alert = "登録に成功しました。" if @contestant_image.save
    render 'new'
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
    @contestant_images = ContestantImage.where(user_id: current_user.id)
    render 'edit'
  rescue
    @contestant_images = ContestantImage.where(user_id: current_user.id)
    flash.now.alert = "削除に失敗しました。時間を置いて再度お試しください。"
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
