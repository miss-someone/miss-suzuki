class UserProfilesController < ApplicationController
  # TODO: ログイン制限追加
  before_filter :voter?

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
      redirect_to root_path, flush: 'プロフィール情報が登録されました'
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
      redirect_to user_profile_path, flush: 'プロフィール情報が更新されました．'
    else
      render :edit
    end
  end

  private

  def voter?
    current_user.present? && current_user.voter?
  end

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
