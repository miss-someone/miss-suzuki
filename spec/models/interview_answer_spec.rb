require 'rails_helper'

RSpec.describe InterviewAnswer, type: :model do
  let!(:interview_topic) { create(:interview_topic) }
  let!(:user) { create(:user) }
  let(:interview_answer) { build(:interview_answer) }

  describe "validation" do
    context "when interview_answer is valid" do
      it "should pass" do
        expect(interview_answer).to be_valid
      end
    end

    describe "about interview_topic_id" do
      context "when it is nil" do
        before { interview_answer.interview_topic_id = nil }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:interview_topic_id)
        end
      end
      context "when interview_topic doesn't exist" do
        before { interview_answer.interview_topic_id = 2 }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:interview_topic_id)
        end
      end
    end

    describe "about user_id" do
      context "when it is nil" do
        before { interview_answer.user_id = nil }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:user_id)
        end
      end
      context "when user doesn't exist" do
        before { interview_answer.user_id = 2 }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:user_id)
        end
      end
    end

    describe "about answer" do
      context "when it is nil" do
        before { interview_answer.answer = nil }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:answer)
        end
      end
      context "when it is 201 characters or more" do
        before { interview_answer.answer = "a" * 201 }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:answer)
        end
        before { interview_answer.answer = "あ" * 201 }
        it "shouldn't pass" do
          expect(interview_answer).not_to be_valid(:answer)
        end
      end
    end
  end
end
