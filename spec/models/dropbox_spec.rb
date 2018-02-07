require 'rails_helper'

RSpec.describe Dropbox, type: :model do
  describe 'associations' do
    it 'should belongs to intern' do
      t = Dropbox.reflect_on_association(:intern)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
