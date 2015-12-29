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
      '<ul>
        <li class="header_btn tab"><a href="/users/signup">新規登録</a></li>
        <li class="header_btn tab"><a href="/login">ログイン</a></li>
      </ul>
      <p class="to_help"><a href="/help">ログイン・会員登録に関するお問い合わせ</a></p>
      '
    end
  end

  def show_my_own_page
    return unless current_user
    return unless current_user.user_type == Settings.user_type.contestant
    '<li class="tab"><a href="/contestants/my_own_page">MY PAGE<br><span>マイページ</span></a></li>'
  end

  def show_entry
    return if current_user && current_user.user_type == Settings.user_type.contestant
    '<li class="tab"><a href="/mister/contestants/entry">ENTRY<br><span>エントリー</span></a></li>'
  end

  def vote_end?
    Time.zone.now > Settings.contestant[:qualifying_vote_limit_day].to_date.in_time_zone.end_of_day
  end

  # FBでシェアする時の画像を指定する
  def fb_meta_tags(controller_name, action_name, contestant_profile)
    if controller_name == "contents" && action_name == "history"
      set_meta_tags og: {
        title: "MISS-SUZUKI | 歴史",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/history",
        image:  "https://miss-suzuki.com/miss-someone/image/upload/v1447324222/history_mainimage_s9z5cl.jpg"
      }
    elsif controller_name == "contents" && action_name == "interview1"
      set_meta_tags og: {
        title: "MISS-SUZUKI | えらい鈴木さんにインタビュー 第１弾！浜松市長 鈴木康友さん！",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/erai_suzukisan1",
        image: "https://miss-suzuki.com/miss-someone/image/upload/v1447324228/interview_mainimage_ql7aw3.jpg"
      }
    elsif controller_name == "contents" && action_name == "interview_sp1"
      set_meta_tags og: {
        title: "MISS-SUZUKI | えらい鈴木さんにインタビュー特別編！鈴木Q太郎さん",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/erai_suzukisan_sp1",
        image: "https://miss-suzuki.com/assets/mainimages/mainimage_qtaro-b07aab0ecf0df82778ac8932db8cd7d5.jpg"
      }
    elsif controller_name == "contents" && action_name == "interview2_1"
      set_meta_tags og: {
        title: "MISS-SUZUKI | えらい鈴木さんにインタビュー 第２弾！スズキ株式会社社長 鈴木俊宏さん！【前編】",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/erai_suzukisan2_1",
        image: "https://miss-suzuki.com/assets/mainimages/interview2_mainimage1-936e2b5a6b463fa91a354040df7052d9.jpg"
      }
    elsif controller_name == "contents" && action_name == "interview2_2"
      set_meta_tags og: {
        title: "MISS-SUZUKI | えらい鈴木さんにインタビュー 第２弾！スズキ株式会社社長 鈴木俊宏さん！【後編】",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/erai_suzukisan2_2",
        image: "https://miss-suzuki.com/assets/mainimages/interview2_mainimage2-7601eea65cf33fc187bb72ca02537b56.jpg"
      }
    elsif controller_name == "contents" && action_name == "akaji"
      set_meta_tags og: {
        title: "MISS-SUZUKI | 【緊急】MISS-SUZUKIが大赤字で困っているので、どれくらい赤字かを髪で表現してみた",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/akaji",
        image: "https://miss-suzuki.com/assets/mainimages/mainimage_akaji-25d9a53b98bbd583bc881e0243c38843.jpg"
      }
    elsif controller_name == "contents" && action_name == "interview3"
      set_meta_tags og: {
        title: "MISS-SUZUKI | えらい鈴木さんにインタビュー 第３弾！三重県知事 鈴木英敬さん！",
        type:  "article",
        url:   "https://miss-suzuki.com/contents/erai_suzukisan3",
        image: "https://miss-suzuki.com/assets/mainimages/interview3_mainimage-524df79b857aeb55f224e619ab3ed3f1.jpg"
      }
    elsif controller_name == "contestants" && contestant_profile.present?
      set_meta_tags og: {
        title: "MISS-SUZUKI | #{contestant_profile.name}さん",
        type:  "article",
        url:   "https://miss-suzuki.com/contestant/#{contestant_profile.user_id}/mypage",
        image: "#{contestant_profile.profile_image.thumb}"
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
