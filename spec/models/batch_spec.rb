require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe 'associations' do
    it 'should have many interns' do
      t = Batch.reflect_on_association(:intern)
      expect(t.macro).to eq(:has_many)
    end

    it 'shouild have one email' do
      t = Batch.reflect_on_association(:email)
      expect(t.macro).to eq(:has_one)
    end

    it 'should have one slack' do
      t = Batch.reflect_on_association(:slack)
      expect(t.macro).to eq(:has_one)
    end
  end

  describe 'validations' do
    it 'should have name presence validation' do
      batch = Batch.create
      batch.valid?
      expect(batch.errors[:name]).to include("can't be blank")
    end

    it 'should have name uniqueness validation' do
      Batch.create({name: 'STEP1'})
      batch = Batch.create({name: 'STEP1'})
      batch.valid?
      expect(batch.errors[:name]).to include('has already been taken')
    end

    it 'should not allow when end date is present without start date' do
      batch = Batch.create({name: 'STEP1', end_date: Date.today})
      expect(batch.errors[:start_date]).to include('cannot be empty when end date is present')
    end

    it 'should not allow end date less than start date' do
      batch = Batch.create({name: 'STEP1', start_date: Date.today, end_date: Date.yesterday})
      expect(batch.errors[:end_date]).to include('cannot be before start date')
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

    it 'should give all the batches except the given batch id' do
      batches = Batch.all_except Batch.all[1].id
      expect(batches.size).to eq(2)
      expect(batches[0].name).to eq('STEP-3')
      expect(batches[1].name).to eq('STEP-1')
    end
  end
end
