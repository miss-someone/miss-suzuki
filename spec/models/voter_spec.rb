require 'rails_helper'

RSpec.describe Voter, type: :model do
  let(:voter) { create(:voter) }

  describe "in validation" do
    let(:voter2) { build(:voter2) }

    describe 'for email' do
      context 'when email is valid' do
        it { expect(voter2).to be_valid() }
      end
      context 'when email is nil' do
        before { voter2.email = nil }
        it { expect(voter2).not_to be_valid(:email) }
      end
      context 'when email contains "+"' do
        before { voter2.email = "suzuki1+alias@gmail.com" }
        it { expect(voter2).not_to be_valid(:email) }
      end
      context 'when email is already registered' do
        before { voter2.email = voter.email }
        it { expect(voter2).not_to be_valid(:email) }
      end
      context 'when email with gmail dots alias is already registered' do
        before { create(:dot_alias1) }
        let(:alias2) { build(:dot_alias2) }
        it { expect(alias2).not_to be_valid(:email) }
      end
    end
  end
end
