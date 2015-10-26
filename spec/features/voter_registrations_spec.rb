require 'rails_helper'

RSpec.feature "VoterRegistrations", type: :feature do
  subject { page }
  before { visit signup_path }
  let(:submit) { '登録' }
  let(:voter) { build(:voter) }

  describe "in case of failuers" do
    context "when i click submit button with all empty fields" do
      describe "about user count" do
        it { expect { click_button submit }.not_to change(User, :count) }
      end
      describe "about error message" do
        before { click_button submit }
        it { expect(subject).to have_css('.error_msg') }
      end
    end

    context "when email field is empty and password field is not empty" do
      before do
        fill_in "voter[password]", with: voter.password
        click_button submit
      end
      it { expect(subject).to have_css('.error_msg') }
    end

    context "when email field isn't empty and password field is empty" do
      before do
        fill_in "voter[email]", with: voter.email
        check "voter[agreement]"
        click_button submit
      end
      it { expect(subject).to have_css('.error_msg') }
    end
  end

  context "when password and email are valid" do
    before do
      fill_in "voter[email]", with: voter.email
      fill_in "voter[password]", with: voter.password
      check "voter[agreement]"
    end
    describe "about user count" do
      it { expect { click_button submit }.to change(User, :count).by(1) }
    end
    describe "about error msg" do
      before { click_button submit }
      it { expect(subject).not_to have_css('.error_msg') }
    end
  end

  describe "about agreement" do
    before do
      fill_in "voter[email]", with: voter.email
      fill_in "voter[password]", with: voter.password
    end
    context "when agreement checkbox isn't checked" do
      describe "about user count" do
        it { expect { click_button submit }.to change(User, :count).by(0) }
      end
      describe "about error msg" do
        before { click_button submit }
        it { expect(subject).to have_css('.error_msg') }
      end
    end
    context "when agreement checkbox is checked" do
      before { check "voter[agreement]" }
      describe "about user count" do
        it { expect { click_button submit }.to change(User, :count).by(1) }
      end
      describe "about error msg" do
        before { click_button submit }
        it { expect(subject).not_to have_css('.error_msg') }
      end
    end
  end
end
