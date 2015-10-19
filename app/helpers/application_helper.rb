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

  # FBでシェアする時の画像を指定する
  def fb_share_setting
    if class: "fb-history"
      <meta property="og:title" content="MISS-SUZUKI | 歴史" />
      <meta property="og:type" content="article" />
      <meta property="og:url" content="https://miss-suzuki.com/history" />
      <meta property="og:image" content="https://miss-suzuki.com/assets/mainimages/history_mainimage-83b98a17d4615164c83b5f68e906a20b.jpg" />
    else
      <meta property="og:title" content="MISS-SUZUKI | <%= @contestant.name %>さん" />
      <meta property="og:type" content="article" />
      <meta property="og:url" content="https://miss-suzuki.com/contestant/<%= @contestant.id %>/mypage" />
      <meta property="og:image" content="<%= @contestant.profile_image %>" />
    end
  end
end
