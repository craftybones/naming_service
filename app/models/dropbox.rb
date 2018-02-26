class Dropbox < ApplicationRecord
  self.table_name = 'dropbox_info'
  belongs_to :intern

  scope :username, -> (username) { where username: username }

end
