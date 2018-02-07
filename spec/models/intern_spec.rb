require 'rails_helper'

RSpec.describe Intern, type: :model do
  describe 'associations' do
    it 'should have many emails' do
      t = Intern.reflect_on_association(:emails)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have github details' do
      t = Intern.reflect_on_association(:github)
      expect(t.macro).to eq(:has_one)
    end

    it 'should have slack details' do
      t = Intern.reflect_on_association(:slack)
      expect(t.macro).to eq(:has_one)
    end

    it 'should have dropbox details' do
      t = Intern.reflect_on_association(:dropbox)
      expect(t.macro).to eq(:has_one)
    end
  end
end
