require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:contestant) { create(:contestant) }
  target_get_actions = [:index, :about, :rules, :how_to_vote, :flow_chart, :next,
                        :entrypolicy, :terms, :policy]
  before do
    # Cloudinaryのモジュールを使っているため，image_url=が
    # 書き換えられており，buildメソッドでは追加されないためここで追加
    contestant_profile = build(:contestant_profile)
    contestant_profile.user_id = contestant.id
    contestant_profile[:profile_image] = "hogehoge.jpg"
    contestant = contestant_profile
    contestant.save!
  end

  target_get_actions.each do |get_action|
    describe "##{get_action}" do
      subject(:response) { get get_action }
      it { expect(response.status).to eq 200 }
    end
  end
end
