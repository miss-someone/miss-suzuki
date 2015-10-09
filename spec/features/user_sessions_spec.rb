require 'rails_helper'

RSpec.feature "UserSessions", type: :feature do
  describe "Authentication" do
    before { visit login_path }

    describe "with invalid infomation" do
      before { click_button "Log in" }

      it { expect(page).to have_selector('div#flash_alert') }
    end

    describe "with valid information" do
      let!(:user) { create(:user) }
      before do
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button "Log in"
      end
      it { expect(page).to have_link 'ログイン' }
      # it { expect(page).to have_link 'ログアウト' }
    end
  end
end
