require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:contestant) { create(:contestant) }
  let(:user_profile) { build(:user_profile) }
  let(:contestant_profile) { build(:contestant_profile) }
  before do
    user_profile.user_id = user.id
    contestant_profile.user_id = contestant.id
    user_profile.save
    contestant_profile.save
  end

  describe "profile method" do
    context "in normal user" do
      subject { user.profile }
      it "returns user_profile" do
        expect(subject).to be_an_instance_of(UserProfile)
      end
    end
    context "in contestant user" do
      subject { contestant.profile }
      it "returns contestant_profile" do
        expect(subject).to be_an_instance_of(ContestantProfile)
      end
    end
  end
end
