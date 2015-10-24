require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let(:voter) { create(:voter) }
  let(:contestant) { create(:contestant) }

  describe 'create action' do
    subject { post :create, email: user.email, password: user.password, remember_me: 1 }

    # FIXME: 何故か全てログイン失敗する．
    describe 'redirection test' do
      context 'for voter' do
        let(:user) { voter }
        context 'who have not registered profile yet' do
          # it { expect(subject).to redirect_to(new_user_profile_path) }
        end
        context 'who have registered profile already' do
          # it { expect(subject).to redirect_to(root_path) }
        end
      end
      context 'for contestant' do
        let(:user) { contestant }
        # it { expect(subject).to redirect_to(root_path) }
      end
    end
  end

end
