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
end
