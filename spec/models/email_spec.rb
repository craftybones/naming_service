require 'rails_helper'

RSpec.describe Email, type: :model do
  describe 'associations' do
    it 'should belongs to intern' do
      t = Email.reflect_on_association(:intern)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
