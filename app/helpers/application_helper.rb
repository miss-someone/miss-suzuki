module ApplicationHelper
  # ログイン状態に応じてヘッダー表示を切り替える
  def switch_header_contents
    if logged_in?
      if current_user.user_type == Settings.user_type[:contestant]
        '<li class="header_btn tab"><a href="/contestants/my_own_page">マイページ</a></li>
        <li class="header_btn tab"><a href="/logout">ログアウト</a></li>'
      else
        '<li class="header_btn tab"><a href="/logout">ログアウト</a></li>'
      end
    else
      '<li class="header_btn tab"><a href="/users/signup">新規登録</a></li>
       <li class="header_btn tab"><a href="/login">ログイン</a></li>'
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

  # FBでシェアする時の画像を指定する
  def fb_meta_tags(controller_name, action_name, contestant_profile)
    if controller_name == "contents" && action_name == "history"
      set_meta_tags og: {
        title: "MISS-SUZUKI | 歴史",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/history",
        image:  asset_path("/assets/images/mainimages/history_mainimage.jpg")
      }
    elsif controller_name == "contents" && action_name == "interview1"
      set_meta_tags og: {
        title: "MISS-SUZUKI | えらい鈴木さんにインタビュー！",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/erai_suzukisan1",
        image: asset_path("/assets/images/mainimages/interview_mainimage.jpg")
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
