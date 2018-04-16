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

    it 'should belong to a batch' do
      t = Intern.reflect_on_association(:batch)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'should have emp_id, display_name, first_name, last_name, dob, batch, gender presence validation' do
      intern = Intern.create
      intern.valid?
      expect(intern.errors[:emp_id]).to include("can't be blank")
      expect(intern.errors[:display_name]).to include("can't be blank")
      expect(intern.errors[:first_name]).to include("can't be blank")
      expect(intern.errors[:dob]).to include("can't be blank")
      expect(intern.errors[:batch]).to include("can't be blank")
      expect(intern.errors[:gender]).to include("can't be blank")
    end

    it 'should have emp_id number validation' do
      intern = Intern.create(:emp_id => 'ss')
      intern.valid?
      intern.errors.should have_key(:emp_id)
      expect(intern.errors[:emp_id]).to include('is not a number')
    end

    it 'should have phone_number numeric validation' do
      intern = Intern.create(:phone_number => 'ss')
      intern.valid?
      intern.errors.should have_key(:emp_id)
      expect(intern.errors[:phone_number]).to include('is not a number')
    end

    it 'should have phone_number length validation' do
      intern = Intern.create(:phone_number => '90212')
      intern.valid?
      intern.errors.should have_key(:emp_id)
      expect(intern.errors[:phone_number]).to include('is the wrong length (should be 10 characters)')
    end

    it 'should allow male as gender' do
      intern = Intern.create(:gender => 'male')
      intern.valid?
      intern.errors.should_not have_key(:gender)
    end

    it 'should allow female as gender' do
      intern = Intern.create(:gender => 'female')
      intern.valid?
      intern.errors.should_not have_key(:gender)
    end

    it 'should allow others as gender' do
      intern = Intern.create(:gender => 'others')
      intern.valid?
      intern.errors.should_not have_key(:gender)
    end

    it 'should not allow other than male, female, others as gender' do
      intern = Intern.create(:gender => 'oth')
      intern.valid?
      intern.errors.should have_key(:gender)
      expect(intern.errors[:gender]).to include('is not included in the list')
    end

    it 'should not allow current or future dates as date of birth' do
      intern = Intern.create(:dob => Date.current.to_s)
      intern.valid?
      intern.errors.should have_key('Date of birth')
      expect(intern.errors['Date of birth']).to include('must be past')
    end

  end

  describe 'search' do

    before(:each) do
      batch = Batch.create({:name => 'STEP-1'})
      Intern.create({:emp_id => '112233', :display_name => 'Display Name', :first_name => 'First Name', :last_name => 'Last Name',
                    :phone_number => '9000000000', :dob => '12-10-10', :gender => 'male', :batch_id => batch.id,
                    :github_attributes => {:username => 'gitusername'}, :slack_attributes => {:username => 'slackusername'},
                    :dropbox_attributes => {:username => 'dropboxusername'}, :emails_attributes => [{:category => 'TW', :address => 'email@tw.com'}]})
    end

    it 'should search by emp id' do
      search_resuts = Intern.search '112233'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].emp_id).to eq(112233)
    end

    it 'should search by display name' do
      search_resuts = Intern.search 'Display'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].display_name).to eq('Display Name')
    end

    it 'should search by first name' do
      search_resuts = Intern.search 'First'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].first_name).to eq('First Name')
    end

    it 'should search by last name' do
      search_resuts = Intern.search 'last'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].last_name).to eq('Last Name')
    end

    it 'should search by email address' do
      search_resuts = Intern.search 'email'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].emails.size).to eq(1)
      expect(search_resuts[0].emails[0].address).to eq('email@tw.com')
    end

    it 'should search by github username' do
      search_resuts = Intern.search 'git'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].github.username).to eq('gitusername')
    end

    it 'should search by slack username' do
      search_resuts = Intern.search 'slack'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].slack.username).to eq('slackusername')
    end

    it 'should search by dropbox username' do
      search_resuts = Intern.search 'dropbox'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].dropbox.username).to eq('dropboxusername')
    end

    it 'should give empty results when the search term does not match' do
      search_resuts = Intern.search 'random'

      expect(search_resuts.size).to eq(0)
    end
  end

  describe 'filters' do
    before(:each) do
      batch = Batch.create({:name => 'STEP-1'})
      Intern.create({:emp_id => '112233', :display_name => 'Display Name', :first_name => 'First Name', :last_name => 'Last Name',
                     :phone_number => '9000000000', :dob => '12-10-10', :gender => 'male', :batch_id => batch.id,
                     :github_attributes => {:username => 'gitusername'}, :slack_attributes => {:username => 'slackusername'},
                     :dropbox_attributes => {:username => 'dropboxusername'}, :emails_attributes => [{:category => 'TW', :address => 'email@tw.com'}]})
    end

    it 'should fitler interns based on emp_id' do
      interns = Intern.emp_id ('112233')

      expect(interns.size).to eq(1)
      expect(interns[0].emp_id).to eq(112233)
    end

    it 'should filter by display name' do
      interns = Intern.display_name 'Display Name'

      expect(interns.size).to eq(1)
      expect(interns[0].display_name).to eq('Display Name')
    end

    it 'should filter by first name' do
      interns = Intern.first_name 'First Name'

      expect(interns.size).to eq(1)
      expect(interns[0].first_name).to eq('First Name')
    end

    it 'should filter by last name' do
      interns = Intern.last_name 'Last Name'

      expect(interns.size).to eq(1)
      expect(interns[0].last_name).to eq('Last Name')
    end

    it 'should filter by gender' do
      interns = Intern.gender 'male'

      expect(interns.size).to eq(1)
      expect(interns[0].gender).to eq('male')
    end

    it 'should filter by dob' do
      interns = Intern.dob '12-10-10'

      expect(interns.size).to eq(1)
    end

    it 'should filter by batch' do
      interns = Intern.batch 'STEP-1'

      expect(interns.size).to eq(1)
      expect(interns[0].batch.name).to eq('STEP-1')
    end

    it 'should fitler by phone number' do
      interns = Intern.phone_number '9000000000'

      expect(interns.size).to eq(1)
      expect(interns[0].phone_number).to eq('9000000000')
    end

    it 'should search by email address' do
      interns = Intern.email 'email@tw.com'

      expect(interns.size).to eq(1)
      expect(interns[0].emails.size).to eq(1)
      expect(interns[0].emails[0].address).to eq('email@tw.com')
    end

    it 'should filter by github username' do
      interns = Intern.github_username 'gitusername'

      expect(interns.size).to eq(1)
      expect(interns[0].github.username).to eq('gitusername')
    end

    it 'should filter by slack username' do
      interns = Intern.slack_username 'slackusername'

      expect(interns.size).to eq(1)
      expect(interns[0].slack.username).to eq('slackusername')
    end

    it 'should filter by dropbox username' do
      interns = Intern.dropbox_username 'dropboxusername'

      expect(interns.size).to eq(1)
      expect(interns[0].dropbox.username).to eq('dropboxusername')
    end


  end
end
