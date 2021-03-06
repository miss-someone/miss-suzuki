class ContestantsController < ApplicationController
  skip_before_filter :require_login, only: [:entry, :thankyou_sample, :mypage_sample, :index,
                                            :second_stage, :semifinal, :suzukike, :tshirt, :mypage, :thankyou,
                                            :new, :create]

  before_filter :require_contestant_login, only: [:new_interview_answer, :create_interview_answer, :my_own_page]
  before_filter :restrict_contestant_login, only: [:entry, :new, :create]

  def index
    if group_opened?(params[:id].to_i)
      @contestant = Contestant.approved.nth_group(params[:id]).includes(:interview_answers)
                    .includes(:contestant_images).shuffle.group_by.with_index { |_e, i| i % 3 }.values
    else
      not_found
    end
  end

  def second_stage
    ids = Contestant.approved.nth_stage(2).pluck(:id)
    @contestant = Contestant.includes(:contestant_profile).includes(:interview_answers)
                  .includes(:contestant_images).find(ids)
                  .shuffle.group_by.with_index { |_e, i| i % 3 }.values
  end

  def semifinal
    ids = Contestant.approved.semifinal.pluck(:id)
    @contestant = Contestant.includes(:contestant_profile).includes(:interview_answers)
                  .includes(:contestant_images).find(ids)
                  .shuffle.group_by.with_index { |_e, i| i % 3 }.values
  end

  def tshirt
    ids = Contestant.approved.semifinal.pluck(:id)
    @contestant = Contestant.includes(:contestant_profile).includes(:interview_answers)
                  .includes(:contestant_images).find(ids)
                  .shuffle.group_by.with_index { |_e, i| i % 3 }.values
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

  def new_interview_answer
    @interview_answers = InterviewTopic.all.each_with_object([]) do |topic, res|
      res << InterviewAnswer.new(user_id: current_user.id, interview_topic_id: topic.id)
    end
  end

  def create_interview_answer
    @interview_answers = params[:interview_answers].each_with_object([]) do |interview_answer, res|
      res << current_user.interview_answers.new(interview_topic_id: interview_answer[:interview_topic_id],
                                                answer: interview_answer[:answer],
                                                is_pending: true)
    end
    InterviewAnswer.transaction do
      @interview_answers.each do |interview_answer|
        interview_answer.save! unless interview_answer.answer.blank?
      end
    end
    flash.now.alert = "インタビューの回答の登録に成功しました。回答が承認され次第マイページに反映されますのでしばらくお待ちください。"
    render 'new_interview_answer'
  rescue
    flash.now.alert = "インタビューの回答の登録に失敗しました（インタビューの回答は200文字までです）。"
    render 'new_interview_answer'
  end

  def thankyou
    @contestant_profile = Contestant.approved.current_open_group.find(params[:id]).profile
  end

  def mypage
    @contestant_profile = Contestant.approved.current_open_group.find(params[:id]).profile
    @interview_answers = {}
    InterviewTopic.find_each do |interview_topic|
      answers = InterviewAnswer.where(interview_topic_id: interview_topic.id,
                                      is_pending: false,
                                      user_id: params[:id]).order(:updated_at)
      if answers.present?
        answer = answers.last.answer
        topic = interview_topic.topic
        @interview_answers.store(topic, answer)
      end
    end
    @contestant_images = ContestantImage.approved.where(user_id: params[:id])
  end

  def my_own_page
    @contestant_profile = Contestant.find(current_user.id).profile
    @interview_answers = {}
    InterviewTopic.find_each do |interview_topic|
      answers = InterviewAnswer.where(interview_topic_id: interview_topic.id,
                                      is_pending: false,
                                      user_id: current_user.id).order(:updated_at)
      if answers.present?
        answer = answers.last.answer
        topic = interview_topic.topic
        @interview_answers.store(topic, answer)
      end
    end
    @contestant_images = ContestantImage.approved.where(user_id: current_user.id)
  end

  private

  def group_opened?(group_id)
    (1..Settings.current_open_group_id).to_a.include?(group_id)
  end

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
                                       ],
                                       interview_answers_attributes: [:user, :interview_topic_id, :answer]
                                      )
  end
end
