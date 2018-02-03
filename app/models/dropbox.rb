class Dropbox < ApplicationRecord
  self.table_name = 'dropbox_info'
  belongs_to :intern
end
