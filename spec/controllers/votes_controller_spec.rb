require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:contestant) { create(:contestant) }
  let(:user) { create(:user) }
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return("192.168.99.225")
    # Cloudinaryのモジュールを使っているため，image_url=が
    # 書き換えられており，buildメソッドでは追加されないためここで追加
    contestant_profile = build(:contestant_profile)
    contestant_profile.user_id = contestant.id
    contestant_profile[:profile_image] = "hogehoge.jpg"
    contestant = contestant_profile
    contestant.save!
  end

  describe 'POST create' do
    subject { post :create, contestant_id: contestant.id }
    context 'by an user who not logged in' do
      context 'in todays 1st vote' do
        it { expect { subject }.to change(Vote, :count).by(1) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
      end
      context 'in todays 3rd vote' do
        before { 2.times.each { post :create, contestant_id: contestant.id } }
        it { expect { subject }.to change(Vote, :count).by(1) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
      end
      context 'in todays 4th vote' do
        before { 3.times.each { post :create, contestant_id: contestant.id } }
        it { expect { subject }.not_to change(Vote, :count) }
        it { expect { subject }.not_to change { contestant.reload.profile.votes } }
        it { expect(subject).to render_template('exceeded_limitation') }
      end
    end
    context 'by an user who logged in' do
      before { login_user(user) }
      context 'in todays 1st vote' do
        it { expect { subject }.to change(Vote, :count).by(1) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
      end
      context 'in todays 10th vote' do
        before { 9.times.each { post :create, contestant_id: contestant.id } }
        it { expect { subject }.to change(Vote, :count).by(1) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
      end
      context 'in todays 11th vote' do
        before { 10.times.each { post :create, contestant_id: contestant.id } }
        it { expect { subject }.not_to change(Vote, :count) }
        it { expect { subject }.not_to change { contestant.reload.profile.votes } }
        it { expect(subject).to render_template('exceeded_limitation') }
      end
    end
  end
end
