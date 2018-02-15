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

  describe 'search' do

    before(:each) do
      Intern.create({:emp_id => '112233', :display_name => 'Display Name', :first_name => 'First Name', :last_name => 'Last Name',
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
      search_resuts = Intern.search 'slack'

      expect(search_resuts.size).to eq(1)
      expect(search_resuts[0].dropbox.username).to eq('dropboxusername')
    end

    it 'should give empty results when the search term does not match' do
      search_resuts = Intern.search 'random'

      expect(search_resuts.size).to eq(0)
    end
  end
end
