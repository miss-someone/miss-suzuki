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
    contestant = User.new(contestant_params)
    contestant.user_type = Settings.user_type[:contestant]
    if contestant.save
      render root_path
    else
      redirect_to about_path
    end
  end

  private

  def contestant_params
    params.require(:contestant).permit(:name, :hurigana, :age, :come_from,
                                       :comment, :link_url, :thanks_comment,
                                       :image_url, :email, :password, :phone,
                                       :station, :is_interest_in_idol_group)
  end
end
