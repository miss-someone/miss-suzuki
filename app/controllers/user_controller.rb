class UserController < ApplicationController
  def new
    @voter = Voter.new
  end

  def create
    @voter = Voter.new(user_params)
    if @voter.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:voter).permit(:email, :password, :agreement)
  end
end
