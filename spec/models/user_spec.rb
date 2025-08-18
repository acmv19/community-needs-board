require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many posts' do
      assoc = described_class.reflect_on_association(:posts)
      expect(assoc.macro).to eq(:has_many)
    end

    it 'has many comments' do
      assoc = described_class.reflect_on_association(:comments)
      expect(assoc.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is invalid with empty name, email, and password' do
      user = User.new(name: '', email: '', password: '')
      expect(user).not_to be_valid
    end
  end
end
