class Intern < ApplicationRecord
  include PgSearch

  pg_search_scope :search, :against => [:display_name, :first_name, :last_name, :batch]

end
