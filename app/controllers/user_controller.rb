class UserController < ApplicationController
  def new
    @voter = Voter.new
    @voter.profile = UserProfile.new
  end

  def create
    
  end

  private

  def user_params
    params.require(:user).permit()
  end
end
