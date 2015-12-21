class Supports::DataBatches::Semifinal
  # 対象者
  #  id  |      name       | second_stage_votes
  # -----+-----------------+--------------------
  #    7 | 鈴木まりえ |              19604
  #   28 | 鈴木優梨    |              14236
  #   78 | 鈴木朝子    |               9324
  #  101 | 鈴木杏奈    |               6491
  #   89 | 鈴木萌子    |               6053
  #   44 | 鈴木優美香 |               5337
  #    5 | 鈴木理香子 |               5265
  #   73 | 鈴木築詩    |               5053
  #   90 | 鈴木理梨    |               5046
  #   85 | 鈴木咲良    |               4947
  #   66 | 鈴木なつみ |               4933
  #   54 | 鈴木佐也果 |               4840

  def self.execute
    semifinal_ids = [7, 28, 78, 101, 89, 44, 5, 73, 90, 85, 66, 54]

    ContestantProfile.transaction do
      targets = ContestantProfile.find(semifinal_ids)
      targets.each { |c| c.update_attribute(:is_in_semifinal, true) }

      ContestantProfile.find(semifinal_ids).each do |c|
        fail "アップデートされていません．エラーによりトランザクションを中断します" unless c.is_in_semifinal
      end

      ContestantProfile.where('id not in (?)', semifinal_ids).each do |c|
        fail "更新されるべきではないエントリが更新されました．トランザクションを中断します" if c.is_in_semifinal
      end
    end

    print 'セミファイナル出場者の更新に成功しました'
  rescue => e
    print e.message
  end
end
