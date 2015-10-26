class ContestantsController < ApplicationController
  include ArrayUtils

  def index
    @contestant = Array.split3(User.contestants.shuffle)
  end

  def new
    @contestant = Contestant.new
    @contestant.profile = ContestantProfile.new
  end

  def create
    @contestant = Contestant.new(contestant_params)
    if @contestant.save
      render 'completed'
    else
      render 'new'
    end
  end

  def thankyou
    @contestant_profile = Contestant.approved.find(params[:id]).profile
  end

  private

  def contestant_params
    params.require(:contestant).permit(:email, :password, :agreement,
                                       { contestant_tag_ids: [] },
                                       contestant_profile_attributes:
                                        [:name, :hurigana, :age, :come_from, :comment,
                                         :link_url, :thanks_comment, :height,
                                         :profile_image, :email, :password, :phone,
                                         :station, :is_interest_in_idol_group,
                                         :how_know, :is_share_with_twitter_ok,
                                         :profile_image_crop_param_x, :profile_image_crop_param_y,
                                         :profile_image_crop_param_height,
                                         :profile_image_crop_param_width
                                        ]
                                      )
  end
end
