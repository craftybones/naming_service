class Slack < ApplicationRecord
  self.table_name = 'slack_info'
  belongs_to :intern
end
