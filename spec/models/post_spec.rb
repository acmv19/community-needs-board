require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      assoc = described_class.reflect_on_association(:comments)
      expect(assoc.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is invalid without a title and content' do
      post = Post.new(title: '', content: '')
      expect(post).not_to be_valid
    end
  end
end
