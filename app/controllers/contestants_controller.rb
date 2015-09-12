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
    # TODO: うまい方法を考えてリファクタ
    is_agree = contestant_params[:agreement]
    params = contestant_params
    params.delete(:agreement) # Contestantの作成には必要ないので削除
    params[:contestant_profile_attributes][:group_id] = Settings.current_group_id

    @contestant = Contestant.new(params)
    if is_agree.blank? || !is_agree
      @contestant.errors.add(:agreement, "に同意してください")
      render 'new'
      return
    end
    if @contestant.save
      render 'completed'
    else
      render 'new'
    end
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
                                         :how_know, :is_share_with_twitter_ok
                                        ]
                                      )
  end
end
