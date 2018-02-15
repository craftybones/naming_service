class Intern < ApplicationRecord

  has_many :emails
  has_one :github
  has_one :slack
  has_one :dropbox

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

end
