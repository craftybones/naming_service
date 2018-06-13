class Intern < ApplicationRecord

  before_save :default_values

  belongs_to :batch
  has_many :emails, as: :emailable, dependent: :delete_all
  has_one :github, dependent: :destroy
  has_one :slack, as: :slackable, dependent: :destroy
  has_one :dropbox, dependent: :destroy

  accepts_nested_attributes_for :github, :reject_if => :all_blank
  accepts_nested_attributes_for :slack, :reject_if => :all_blank
  accepts_nested_attributes_for :dropbox, :reject_if => :all_blank
  accepts_nested_attributes_for :emails

  validates :emp_id, :display_name, :first_name, :dob, :gender, presence: true
  validates :phone_number, numericality: true, length: {is: 10}, if: :phone_number_present?
  validates :emp_id, numericality: true, length: {maximum: 10}, if: :emp_id_present?
  validates :gender, inclusion: {in: %w(male female others)}
  validate :validate_dob

  scope :emp_id, -> (emp_id) {where emp_id: emp_id}
  scope :display_name, -> (display_name) {where display_name: display_name}
  scope :first_name, -> (first_name) {where first_name: first_name}
  scope :last_name, -> (last_name) {where last_name: last_name}
  scope :batch, -> (batch) {joins(:batch).merge(Batch.find_by(name: batch))}
  scope :dob, -> (dob) {where dob: dob}
  scope :phone_number, -> (phone_number) {where phone_number: phone_number}
  scope :gender, -> (gender) {where gender: gender}
  scope :email, -> (address) {joins(:emails).merge(Email.address(address))}
  scope :github_username, -> (username) {joins(:github).merge(Github.username(username))}
  scope :dropbox_username, -> (username) {joins(:dropbox).merge(Dropbox.username(username))}
  scope :slack_username, -> (username) {joins(:slack).merge(Slack.username(username))}

  def self.search search_term
    left_outer_joins(:emails).left_outer_joins(:github)
        .left_outer_joins(:slack).left_outer_joins(:dropbox)
        .where(search_query, {:search_term => "%#{search_term}%"})
  end

  def attributes
    {
        :id => nil,
        :display_name => nil,
        :first_name => nil,
        :last_name => nil,
        :emp_id => nil,
        :dob => nil,
        :gender => nil,
        :phone_number => nil,
        :present_in_tw => nil,
        :created_at => nil,
        :updated_at => nil,
    }
  end

  private

  def default_values
    self.present_in_tw = self.present_in_tw != nil ? self.present_in_tw : true;
  end

  def self.search_query
    (searchable_fields.map {|field|
      "#{field} LIKE :search_term"
    }).join(' OR ')
  end

  def self.searchable_fields
    %w(emp_id display_name first_name last_name emails.address github_info.username slack_info.username dropbox_info.username )
  end


  def validate_dob
    if dob != nil && dob >= Date.current
      errors.add('Date of birth', 'must be past')
    end
  end

  def phone_number_present?
    !phone_number.blank?
  end

  def emp_id_present?
    !emp_id.blank?
  end

end
