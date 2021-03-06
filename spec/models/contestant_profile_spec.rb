require 'rails_helper'

shared_examples_for "presence validation(string)" do
  context "with valid parameters" do
    it { expect(profile).to be_valid }
  end
  context "with invalid parameters" do
    before { profile.send("write_attribute", target_attr, nil) }
    it { expect(profile).not_to be_valid(target_attr) }
    before { profile.send("write_attribute", target_attr, "") }
    it { expect(profile).not_to be_valid(target_attr) }
  end
end

RSpec.describe User, type: :model do
  let(:contestant) { create(:contestant) }
  let(:contestant_profile) { build(:contestant_profile) }
  before do
    contestant_profile.user_id = contestant.id
    # Cloudinaryのモジュールを使っているため，image_url=が
    # 書き換えられており，buildメソッドでは追加されないためここで追加
    contestant_profile[:profile_image] = "hogehoge.jpg"
  end

  describe "validation" do
    describe "about name" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "name" }
      end
    end
    describe "about hurigana" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "hurigana" }
      end
    end
    describe "about image_url" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "profile_image" }
      end
    end
    describe "about height" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "height" }
      end
    end
    describe "about come_from" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "come_from" }
      end
    end
    describe "about comment" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "comment" }
      end
    end
    describe "about thanks_comment" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "thanks_comment" }
      end
    end
  end
end
