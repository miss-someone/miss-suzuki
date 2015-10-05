module StaticPagesHelper
  def div_contestant_class(contestant_array, contestant)
    contestant_array.last.id != contestant.id ? "contestant" : "contestant last"
  end
end
