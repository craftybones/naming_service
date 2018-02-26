class Intern < ApplicationRecord

  has_many :emails, dependent: :delete_all
  has_one :github, dependent: :destroy
  has_one :slack, dependent: :destroy
  has_one :dropbox, dependent: :destroy

  accepts_nested_attributes_for :github
  accepts_nested_attributes_for :slack
  accepts_nested_attributes_for :dropbox
  accepts_nested_attributes_for :emails

  validates :emp_id, :display_name, :first_name, :last_name, :dob, :batch, :gender, presence: true
  validates :phone_number, numericality: true, length: { is: 10 }
  validates :emp_id, :batch, numericality: true
  validates :gender, inclusion: { in: %w(male female others) }
  validate :validate_dob

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


  def validate_dob
    if dob != nil && dob >= Date.current
      errors.add('Date of birth', 'must be past')
    end
  end
end
