class Github < ApplicationRecord
  self.table_name = 'github_info'
  belongs_to :intern
end
