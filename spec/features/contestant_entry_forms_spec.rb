require 'rails_helper'

RSpec.feature "ContestantEntryForms", type: :feature do
  describe "Contestant entry paage" do
    subject { page }
    before { visit new_path }
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
        fill_in "email", contestant.email
        fill_in "password", contestant.password
      end
      it "should create user" do
        expect { click_button submit }.to change(User, :count)
      end
    end
  end
end
