require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe 'validations' do
    it 'should have name presence validation' do
      batch = Batch.create
      batch.valid?
      expect(batch.errors[:name]).to include("can't be blank")
    end
  end

  describe 'scope methods' do
    before(:each) do
      Batch.create({:name => 'STEP-1', :start_date => '07-01-2012', :end_date => '07-07-2014'})
      Batch.create({:name => 'STEP-2', :start_date => '07-01-2013', :end_date => '07-07-2015'})
      Batch.create({:name => 'STEP-3', :start_date => '07-01-2014', :end_date => '07-07-2016'})
    end

    it 'should give all batches in latest first order' do
      batches = Batch.all
      expect(batches.size).to eq(3)
      expect(batches[0].name).to eq('STEP-3')
      expect(batches[1].name).to eq('STEP-2')
      expect(batches[2].name).to eq('STEP-1')
    end

    it 'should give all the batches except the give batch id' do
      batches = Batch.all_except 2
      expect(batches.size).to eq(2)
      expect(batches[0].name).to eq('STEP-3')
      expect(batches[1].name).to eq('STEP-1')
    end

  end
end
