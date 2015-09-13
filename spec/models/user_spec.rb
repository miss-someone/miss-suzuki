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
    # Cloudinaryのモジュールを使っているため，image_url=が
    # 書き換えられており，buildメソッドでは追加されないためここで追加
    contestant_profile[:profile_image] = "hogehoge.jpg"
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
    describe " for email" do
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
    end
    describe "for user_type" do
      context "when user_type is out of range" do
        before { user1.user_type = 3 }
        it "shouldn't pass" do
          expect(user1).not_to be_valid(:user_type)
        end
      end
      context "when user_type is in range" do
        before { user1.user_type = 1 }
        it "should pass" do
          expect(user1).to be_valid
        end
      end
    end
    describe "for password" do
      context "when password is blank" do
        before { user1.password = "" }
        it "shouldn't pass" do
          expect(user1).not_to be_valid(:password)
        end
      end
      context "when passowrd is too short" do
        before { user1.password = "hoge" }
        it "shouldn't pass" do
          expect(user1).not_to be_valid(:password)
        end
      end
      context "when passowrd is too long" do
        before { user1.password = "h" * 31 }
        it "shouldn't pass" do
          expect(user1).not_to be_valid(:password)
        end
      end
      context "when password is invalid valud" do
        before { user1.password = "hogeあいﾁ" }
        it "shouldn't pass" do
          expect(user1).not_to be_valid(:password)
        end
      end
      context "when password has ascii symbols" do
        before { user1.password = '1~!@#$%^&*()_+{}|[]\:";<>?,./' }
        it "should pass" do
          expect(user1).to be_valid(:password)
        end
      end
    end
  end
end
