require 'rails_helper'

RSpec.describe Github, type: :model do
  describe 'associations' do
    it 'should belongs to intern' do
      t = Github.reflect_on_association(:intern)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
