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
    contestant_profile[:image_url] = "hogehoge.jpg"
  end

  describe "validation" do
    describe "about group_id" do
      context "when it is not nil and valid" do
        it "should pass" do
          expect(contestant_profile).to be_valid
        end
      end
      context "when it is nil" do
        before { contestant_profile.group_id = nil }
        it "shouldn't pass" do
          expect(contestant_profile).not_to be_valid(:group_id)
        end
      end
      context "when it is out of range" do
        before { contestant_profile.group_id = 4 }
        it "shouldn't pass" do
          expect(contestant_profile).not_to be_valid(:group_id)
        end
      end
    end
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
        let(:target_attr) { "image_url" }
      end
    end
    describe "about age" do
      it_behaves_like "presence validation(string)" do
        let(:profile) { contestant_profile }
        let(:target_attr) { "age" }
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
