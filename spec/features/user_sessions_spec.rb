require 'rails_helper'

RSpec.feature "UserSessions", type: :feature do
  describe "Authentication" do
    before { visit login_path }

    describe "パスワードが空欄の時エラーメッセージが出る" do
      before { click_button "Log in" }

      it { should have_selector('h1') }
    end
  end
end
