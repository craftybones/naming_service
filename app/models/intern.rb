class Intern < ApplicationRecord

  has_many :emails, dependent: :delete_all
  has_one :github, dependent: :destroy
  has_one :slack, dependent: :destroy
  has_one :dropbox, dependent: :destroy

  accepts_nested_attributes_for :github
  accepts_nested_attributes_for :slack
  accepts_nested_attributes_for :dropbox
  accepts_nested_attributes_for :emails

  def build_dependents
    build_github
    build_dropbox
    build_slack

    ['ThoughtWorks', 'Personal'].each { |category|
      self.emails.build({category: category})
    }
  end

  def self.search search_term
    joins(:github).joins(:slack).joins(:emails).joins(:dropbox).where(search_query, {:search_term => "%#{search_term}%"})
  end

  private
  def self.search_query
    (searchable_fields.map { |field|
      "#{field} LIKE :search_term"
    }).join(' OR ')
  end

  def self.searchable_fields
    %w(emp_id display_name first_name last_name github_info.username slack_info.username dropbox_info.username emails.address)
  end

end
