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

  describe "validation" do
    let(:user1) { build(:user1) }
    context "when email is nil" do
      before { user1.email = nil }
      it "shouldn't pass" do
        expect(user1).not_to be_valid(:email)
      end
    end
    context "when email is not nil and valid" do
      it "should pass" do
        expect(user1).to be_valid
      end
    end
    context "when email already exists" do
      before { user1.email = user.email }
      it "shouldn't pass" do
        expect(user1).not_to be_valid(:email)
      end
    end
    context "when user_type is out of range" do
      before { user1.user_type = 3 }
      it "shouldn't pass" do
        expect(user1).not_to be_valid(:user_type)
      end
    end
    context "when user_type in in range" do
      before { user1.user_type = 1 }
      it "should pass" do
        expect(user1).to be_valid
      end
    end
  end
end
