class ContestantsController < ApplicationController
  include ArrayUtils

  def index
    @contestant = Array.split3(User.contestants.shuffle)
  end

  def new
    @contestant = Contestant.new
    @contestant.profile = ContestantProfile.new
  end
end
