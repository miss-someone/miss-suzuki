require 'rails_helper'

RSpec.feature "ContestantEntryForms", type: :feature do
# 会期が終わって色々塞ぐのでテスト止める
=begin

  describe "Contestant entry paage" do
    subject { page }
    before { visit new_contestant_path }
    let(:submit) { "送信する" }

    context "with invalid information" do
      it "should not create user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    context "with valid information" do
      let(:contestant) { build(:contestant) }
      let(:profile) { build(:contestant_profile) }
      before do
        fill_in "contestant[email]", with: contestant.email
        fill_in "contestant[password]", with: contestant.password
        fill_in "contestant[contestant_profile_attributes][name]", with: profile.name
        fill_in "contestant[contestant_profile_attributes][hurigana]", with: profile.hurigana
        fill_in "contestant[contestant_profile_attributes][age]", with: profile.age
        fill_in "contestant[contestant_profile_attributes][come_from]", with: profile.come_from
        fill_in "contestant[contestant_profile_attributes][height]", with: profile.height
        fill_in "contestant[contestant_profile_attributes][comment]", with: profile.comment
        fill_in "contestant[contestant_profile_attributes][link_url]", with: profile.link_url
        fill_in "contestant[contestant_profile_attributes][thanks_comment]", with: profile.thanks_comment
        attach_file "contestant[contestant_profile_attributes][profile_image]", (Rails.root + "spec/data/test.jpg").to_s
        fill_in "contestant[contestant_profile_attributes][phone]", with: profile.phone
        fill_in "contestant[contestant_profile_attributes][station]", with: profile.station
        fill_in "contestant[contestant_profile_attributes][how_know]", with: profile.how_know
        choose "contestant_contestant_profile_attributes_is_share_with_twitter_ok_true"
        choose "contestant_contestant_profile_attributes_is_interest_in_idol_group_true"
        fill_in "contestant[contestant_profile_attributes][station]", with: profile.station
        check "contestant[agreement]"
      end
      it "should create user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      context "but agreement checkbox isn't cheked" do
        before { uncheck "contestant[agreement]" }
        it { expect { click_button submit }.to change(User, :count).by(0) }
      end
    end
  end
=end
end
