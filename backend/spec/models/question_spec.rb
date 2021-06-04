require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:user_admin) { create(:user) }
  let!(:user_teacher) { create(:user_teacher) }
  let!(:user_moderator) { create(:user_moderator) }
  let!(:question) { create(:question) }
  let!(:question_teacher) { create(:question, user: user_teacher) }
  let!(:question_multiple) { create(:multiple_choice_question) }
  let!(:question_single) { create(:single_choice_question) }
  let!(:question_type_single) { create(:question_type_single) }

  it { expect(question).to be_valid }

  describe 'relationship' do
    it { is_expected.to belong_to(:question_type).required }
    it { is_expected.to belong_to(:survey).optional }
    it { is_expected.to belong_to(:user).required }
    it { is_expected.to have_many(:options).dependent(:destroy) }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'when updating to single choice with multiple correct options.' do
    before do
      create_list(:option, 3, correct: true, question_id: question_multiple.id)
      question_multiple.update(question_type_id: question_type_single.id)
    end

    it { expect(question_multiple).not_to be_valid }
    it { expect(question_multiple.errors.full_messages).to match(["Question type Can't change to single choice when having more than one correct option."]) }
  end

  describe '#single_choice?' do
    it { expect(question_single.single_choice?).to eq(true) }
    it { expect(question_multiple.single_choice?).to eq(false) }
  end

  describe 'uniqueness by user' do
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe '.by_user' do
    it { expect(described_class.by_user(user_teacher)).to eq([question_teacher]) }
    it { expect(described_class.by_user(user_admin)).to include(question_single, question, question_multiple, question_teacher) }
    it { expect(described_class.by_user(user_moderator)).to eq([]) }
  end
end
