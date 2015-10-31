module ApplicationHelper
  # ログイン状態に応じてヘッダー表示を切り替える
  def switch_header_contents
    if current_user
      # TODO: マイページ編集機能が実装したら、ここからリンク
      # <li class="header_btn tab"><a href="/mypage">マイページ</a></li>
      ' <li class="header_btn tab"><a href="/logout">ログアウト</a></li>'
    else
      # TODO: 一般投票者用の登録機能ができたら、ここからリンク
      # ' <li class="header_btn tab"><a href="/login">新規登録</a></li>'
      ' <li class="header_btn tab"><a href="/login">ログイン</a></li>'
    end
  end

  def show_my_own_page
    return unless current_user
    return unless current_user.user_type == Settings.user_type.contestant
    '<li class="tab"><a href="/contestants/my_own_page">MY PAGE<br><span>マイページ</span></a></li>'
  end

  def show_entry
    return if current_user && current_user.user_type == Settings.user_type.contestant
    '<li class="tab"><a href="/contestants/entry">ENTRY<br><span>エントリー</span></a></li>'
  end
end
