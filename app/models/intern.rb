class Intern < ApplicationRecord
  include PgSearch

  has_many :emails

  pg_search_scope :search, :against => [:display_name, :first_name, :last_name, :batch],
                  :associated_against => {
                      :emails => :address
                  }

end
