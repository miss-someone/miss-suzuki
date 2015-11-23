class ContentsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :history, :interview1, :interview1_2]
  def history
  end

  def interview1
  end

  def interview1_2
  end
end
