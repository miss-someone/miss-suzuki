class ContestantImageController < ApplicationController
  def new
    @contestant_image = ContestantImage.new
  end

  def create
    @contestant_image = ContestantImage.new(contestant_image_params)
    @contestant_image.user_id = current_user.id
    @contestant_image.errors[:base] << "登録に成功しました。" if @contestant_image.save
    render 'new'
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
