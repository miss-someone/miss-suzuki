class UserProfilesController < ApplicationController
  before_filter :require_voter_login
  before_action :voter?

  def show
    @user = current_user
  end

  def new
    if current_user.profile.present?
      redirect_to edit_user_profile_path
    else
      @profile = UserProfile.new
    end
  end

  def create
    @profile = current_user.build_user_profile(user_profile_params)
    if @profile.save
      redirect_to root_path, flash: { success: 'プロフィール情報が登録されました！ミス鈴木をお楽しみください！' }
    else
      render :new
    end
  end

  def edit
    if current_user.profile.present?
      @profile = current_user.profile
    else
      redirect_to new_user_profile_path
    end
  end

  def update
    if current_user.profile.update(user_profile_params)
      redirect_to edit_user_profile_path, flash: { success: 'プロフィール情報が更新されました' }
    else
      render :edit
    end
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(
      :nickname,
      :sex,
      :age_id,
      :prefecture_code,
      :job_id
    )
  end
end
