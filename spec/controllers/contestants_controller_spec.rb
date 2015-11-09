require 'rails_helper'

RSpec.describe ContestantsController, type: :controller do
  let(:contestant) { create(:contestant) }
  before do
    # Cloudinaryのモジュールを使っているため，image_url=が
    # 書き換えられており，buildメソッドでは追加されないためここで追加
    contestant_profile = build(:contestant_profile)
    contestant_profile.user_id = contestant.id
    contestant_profile[:profile_image] = "hogehoge.jpg"
    contestant = contestant_profile
    contestant.save!
  end

  describe '#index' do
    subject (:response) { get :index, id: 1 }
    it { expect(response.status).to eq 200 }
  end

  describe '#new' do
    subject (:response) { get :new }
    it { expect(response.status).to eq 200 }
  end

  describe '#mypage' do
    subject (:response) { get :mypage, id: contestant.id }
    it { expect(response.status).to eq 200 }
  end
  describe '#thankyou' do
    subject (:response) { get :thankyou, id: contestant.id }
    it { expect(response.status).to eq 200 }
  end
end
