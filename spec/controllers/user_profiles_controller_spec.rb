require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do
  before do
    login_user(voter)
  end

  let(:voter) { create(:voter) }
  let(:post_data) do
    {
      nickname: 'クラウド',
      sex: Settings.sex[:male],
      age_id: 2,
      prefecture_code: 10,
      job_id: 2
    }
  end

  describe 'new action' do
    subject { get :new }
    context 'with user who do not have profile' do
      it { expect(subject).not_to redirect_to(edit_user_profile_path) }
    end
    context 'with user who alredy have progile' do
      before { voter.profile = build(:user_profile) }
      it { expect(subject).to redirect_to(edit_user_profile_path) }
    end
  end

  describe 'create action' do
    subject { post :create, user_profile: post_data }
    it { expect { subject }.to change(UserProfile, :count).by(1) }
  end

  describe 'edit action' do
    subject { get :edit }
    context 'with user who do not have profile' do
      it { expect(subject).to redirect_to(new_user_profile_path) }
    end
    context 'with user who alredy have progile' do
      before { voter.profile = build(:user_profile) }
      it { expect(subject).not_to redirect_to(new_user_profile_path) }
    end
  end

  describe 'update action' do
    before { voter.profile = build(:user_profile) }
    subject { post :update, user_profile: post_data }
    it do
      expect { subject }.to change(voter.profile, :nickname)
        .from(voter.profile.nickname).to(post_data[:nickname])
    end
  end
end
