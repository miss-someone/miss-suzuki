module ContestantImagesHelper
  # 紹介リンクへのボタンを作成
  def show_blank_message(img)
    '<p>現在登録されているマイページ掲載写真はありません</p>' if img.nil?
  end
end
