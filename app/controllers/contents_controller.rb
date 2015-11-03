class ContentsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :history, :interview1]
  def history
  end

  def interview1
  end
end
