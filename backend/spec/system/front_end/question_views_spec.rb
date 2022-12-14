require 'rails_helper'

RSpec.describe 'Question', type: :system do
  let!(:user) { create(:user_student) }
  let!(:question) { create(:multiple_choice_question) }

  describe '#show' do
    before do
      sign_in user
      visit question_path question
    end

    it 'displays the name of the question' do
      expect(page).to have_content question.name
    end

    it 'displays the options of the question' do
      question.options.each do |option|
        expect(page).to have_content option.name
      end
    end

    context 'when single question type' do
      let(:question) { create(:single_choice_question) }

      it { expect(page).to have_content 'Single choice question' }
    end

    context 'when multiple question type' do
      it { expect(page).to have_content 'Multiple choice question' }
    end

    context 'when free text question type' do
      let(:question) { create(:free_text_question) }

      it { expect(page).to have_content 'Free text question' }
    end
  end
end
