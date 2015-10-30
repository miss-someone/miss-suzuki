require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:contestant) { create(:contestant) }
  let(:user) { create(:user) }
  let(:user1) { create(:user1) }
  let(:ip1) { "10.105.17.19" }
  let(:ip2) { "10.105.18.128" }
  let(:today) { Date.new(2015, 11, 1) }
  let(:tomorrow) { Date.new(2015, 11, 2) }
  let(:not_login_limit) { Settings.vote[:daily_limit][:not_logined] }
  let(:with_login_limit) { Settings.vote[:daily_limit][:logined] }
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(ip1)
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
    before(:each) { Timecop.freeze(today) }
    after(:each) { Timecop.return }
    context 'by an user who not logged in' do
      context 'in todays 1st vote' do
        it { expect { subject }.to change(Vote, :count).by(1) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
        context 'when another user already voted 3times' do
          before  do
            not_login_limit.times.each { post :create, contestant_id: contestant.id }
            # 別IPにセット
            allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(ip2)
            # cookieも一度クリア
            cookies.signed[Settings.vote[:token_name]] = nil
          end
          it { expect { subject }.to change(Vote, :count).by(1) }
          it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
          it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
        end
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
      context 'in tomorrows 1st vote(in case of that he has voted 3times today)' do
        before do
          not_login_limit.times.each { post :create, contestant_id: contestant.id }
          Timecop.freeze(tomorrow)
        end
        it { expect { subject }.to change(Vote, :count).from(3).to(4) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
      end
    end

    context 'by an user who logged in' do
      before { login_user(user) }
      context 'in todays 1st vote' do
        it { expect { subject }.to change(Vote, :count).by(1) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
        context 'when another user already voted 10 times' do
          before  do
            with_login_limit.times.each { post :create, contestant_id: contestant.id }
            logout_user
            login_user(user1)
          end
          it { expect { subject }.to change(Vote, :count).by(1) }
          it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
          it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
        end
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
      context 'in tomorrows 1st vote(in case of that he has voted 10times today)' do
        before do
          with_login_limit.times.each { post :create, contestant_id: contestant.id }
          Timecop.freeze(tomorrow)
        end
        it { expect { subject }.to change(Vote, :count).from(10).to(11) }
        it { expect { subject }.to change { contestant.reload.profile.votes }.by(1) }
        it { expect(subject).to redirect_to(contestants_thankyou_path(contestant.id)) }
      end
    end
  end
end
