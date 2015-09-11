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
    params = contestant_params
    params[:contestant_profile_attributes][:group_id] = 1
    @contestant = Contestant.new(params)
    if @contestant.save!
      redirect_to root_path
    else
      redirect_to about_path
    end
  end

  private

  def contestant_params
    params.require(:contestant).permit(:email, :password,
                                       { contestant_tag_ids: [] },
                                       contestant_profile_attributes:
                                        [:name, :hurigana, :age, :come_from, :comment,
                                         :link_url, :thanks_comment, :height,
                                         :image_url, :email, :password, :phone,
                                         :station, :is_interest_in_idol_group,
                                         :how_know, :is_share_with_twitter_ok
                                        ]
                                      )
  end
end
