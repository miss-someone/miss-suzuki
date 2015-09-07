class ContestantsController < ApplicationController

  def index
    @contestant = Array.slice3(User.contestants.shuffle)
  end


end
