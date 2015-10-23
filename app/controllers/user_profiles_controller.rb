class UserProfilesController < ApplicationController
  def show

  end

  def new

  end
  
  def create

  end

  def edit

  end

  def update

  end

  private

  def user_profile_params
    params.require(:user_profile).permit(
      :nickname,
      :sex,
      :age,
      :prefecture
    )
  end
end
