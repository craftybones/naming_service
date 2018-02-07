class Intern < ApplicationRecord

  has_many :emails
  has_one :github
  has_one :slack
  has_one :dropbox

  accepts_nested_attributes_for :github
  accepts_nested_attributes_for :slack
  accepts_nested_attributes_for :dropbox

  def build_dependents
    build_github
    build_dropbox
    build_slack
  end

end
