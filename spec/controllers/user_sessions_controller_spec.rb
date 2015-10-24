require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  before do
    @voter = create(:voter)
    @contestant = create(:contestant)
  end

  describe 'create action' do
    subject { post :create, email: user.email, password: user.password, remember_me: 1 }

    describe 'redirection test' do
      context 'for voter' do
        let(:user) { @voter }
        context 'who have not registered profile yet' do
          it { expect(subject).to redirect_to(new_user_profile_path) }
        end
        context 'who have registered profile already' do
          it { expect(subject).to redirect_to(root_path) }
        end
      end
      context 'for contestant' do
        let(:user) { @contestant }
        it { expect(subject).to redirect_to(root_path) }
      end
    end
  end

end
