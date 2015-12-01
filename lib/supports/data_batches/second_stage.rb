class Supports::DataBatches::SecondStage
  # 対象者
  #  id | votes |      name
  # ----+-------+-----------------
  #   7 | 12467 | 鈴木まりえ
  #  28 | 12270 | 鈴木優梨
  #  33 |  4031 | 鈴木みなみ
  #   5 |  2005 | 鈴木理香子
  #  23 |  1750 | 鈴木美貴子
  #  24 |  1577 | 鈴木アリサ
  #  14 |  1279 | 鈴木友里絵
  #  18 |   955 | 鈴木笑里
  #  73 |  7461 | 鈴木築詩
  #  66 |  7070 | 鈴木なつみ
  #  44 |  3371 | 鈴木優美香
  #  54 |  3023 | 鈴木佐也果
  #  39 |  1835 | 鈴木美琴
  #  62 |  1622 | 鈴木すみれ
  #  55 |   892 | 鈴木和恵
  #  41 |   763 | 鈴木亜里香
  #  78 |  5519 | 鈴木朝子
  #  89 |  5319 | 鈴木萌子
  #  90 |  3584 | 鈴木理梨
  #  92 |  1946 | 鈴木淳子
  #  76 |  1841 | 鈴木千夏
  #  86 |  1673 | 鈴木理沙
  # 101 |  1468 | 鈴木杏奈
  #  85 |  1308 | 鈴木咲良
  def self.execute
    second_stages = [7, 28, 33, 5, 23, 24, 14, 18, 73, 66, 44, 54, 39, 62, 55, 41, 78, 89, 90, 92, 76, 86, 101, 85]
    ContestantProfile.transaction do
      targets = ContestantProfile.find(second_stages)
      targets.each { |c| c.update_attribute(:is_in_2nd_stage, true) }

      ContestantProfile.find(second_stages).each do |c|
        fail "アップデートされていません．エラーによりトランザクションを中断します" unless c.is_in_2nd_stage
      end

      ContestantProfile.where('id not in (?)', second_stages).each do |c|
        fail "更新されるべきではないエントリが更新されました．トランザクションを中断します" if c.is_in_2nd_stage
      end
    end

    print '第二ステージ出場者の更新に成功しました'
  rescue => e
    print e.message
  end
end
