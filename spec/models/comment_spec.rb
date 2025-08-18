require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      assoc = described_class.reflect_on_association(:post)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is invalid without content' do
      comment = Comment.new(content: '')
      expect(comment).not_to be_valid
    end
  end
end
