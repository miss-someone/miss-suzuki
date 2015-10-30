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

def is_needed_fb_tag?

  if
    display_meta_tags(fb_meta_tags(controller_name, action_name, nil))
  else
    display_meta_tags(fb_meta_tags(controller_name, action_name, @contestant.profile))
  end
end

  # FBでシェアする時の画像を指定する
  def fb_meta_tags(controller_name, action_name, contestant_profile)
    if controller_name == "static_pages" && action_name == "history"
      set_meta_tags og: {
        title: "MISS-SUZUKI | 歴史",
        type:  "article",
        url:   "https://miss-suzuki.com/history",
        image: "https://miss-suzuki.com/assets/mainimages/history_mainimage-83b98a17d4615164c83b5f68e906a20b.jpg"
      }
    elsif controller_name == "contestants" && contestant_profile.present?
      set_meta_tags og: {
        title: "MISS-SUZUKI | #{contestant_profile.name}さん",
        type:  "article",
        url:   "https://miss-suzuki.com/contestant/#{contestant_profile.user_id}/mypage",
        image: "#{contestant_profile.profile_image}"
      }
    else
      set_meta_tags og: {
        title: "MISS-SUZUKI",
        type:  "article",
        url:   "https://miss-suzuki.com",
        image: "/Users/shigeru/miss-suzuki/app/assets/images/catchcopy.png"
      }
    end
  end
end
