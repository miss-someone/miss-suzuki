module StaticPagesHelper
  def div_contestant_class(contestant_array, contestant)
    contestant_array.last.id != contestant.id ? "contestant" : "contestant last"
  end

  def show_entry_btn
    return if current_user && current_user.user_type == Settings.user_type.contestant
    '<p id="entry_btn"><a href="contestants/entry">エントリーはこちら！</a></p>'
  end
end
