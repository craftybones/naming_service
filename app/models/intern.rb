class Intern < ApplicationRecord
  include PgSearch

  has_many :emails
  has_one :github
  has_one :slack
  has_one :dropbox

  pg_search_scope :search, :against => [:display_name, :first_name, :last_name, :batch],
                  :associated_against => {
                      :emails => :address,
                      :github => :username,
                      :slack => :username,
                      :dropbox => :username
                  }

  accepts_nested_attributes_for :github
  accepts_nested_attributes_for :slack
  accepts_nested_attributes_for :dropbox

  def build_dependents
    build_github
    build_dropbox
    build_slack
  end

end
