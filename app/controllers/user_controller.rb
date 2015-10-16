class UserController < ApplicationController
  def new
    @voter = User.new
  end

  def create
    @voter = Voter.new(voter_params)
    if @voter.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def voter_params
    params.require(:voter).permit(:email, :password)
  end
end
