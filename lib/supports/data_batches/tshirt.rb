class Supports::DataBatches::Tshirt
  # Tシャツ審査出場者
  #  id  |      name       | second_stage_votes
  # -----+-----------------+--------------------
  #    7 | 鈴木まりえ |              19604
  #   78 | 鈴木朝子    |               9324
  #  101 | 鈴木杏奈    |               6491
  #   44 | 鈴木優美香 |               5337
  #    5 | 鈴木理香子 |               5265
  #   54 | 鈴木佐也果 |               4840
  #
  def self.execute
    tshirt_ids = [7, 78, 101, 44, 5, 54]

    ContestantProfile.transaction do
      targets = ContestantProfile.find(tshirt_ids)
      targets.each { |c| c.update_attribute(:semifinal_votes, 0) }

      ContestantProfile.all.each { |c| c.update_attribute(:is_in_semifinal, false) }
      targets.each { |c| c.update_attribute(:is_in_semifinal, true) }

      ContestantProfile.find(tshirt_ids).each do |c|
        fail "アップデートされていません．エラーによりトランザクションを中断します" unless c.semifinal_votes == 0
      end

      if ContestantProfile.where(is_in_semifinal: true).count != tshirt_ids.count
        fail "セミファイナル出場者の数が不正です．エラーによりトランザクションを中断します"
      end
    end

    print 'Tシャツ審査出場者の更新に成功しました'
  rescue => e
    print e.message
  end
end
