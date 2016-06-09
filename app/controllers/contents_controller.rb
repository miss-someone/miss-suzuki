class ContentsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :history, :interview1, :interview1_2, :interview_sp1, :interview2_1, :interview2_2, :interview3, :akaji, :fujishiro, :interview4, :report]
  def history
  end

  def interview1
  end

  def interview1_2
  end

  def interview_sp1
  end

  def interview2_1
  end

  def interview2_2
  end

  def interview3
  end

  def akaji
  end

  def fujishiro
  end

  def interview4
  end

  def interview5
  end

  def report
  end
end
