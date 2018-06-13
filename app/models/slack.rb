class Slack < ApplicationRecord
  self.table_name = 'slack_info'
  belongs_to :slackable, polymorphic: true, optional: true

  scope :username, -> (username) { where username: username }

  def attributes
    {
        :id => nil,
        :username => nil,
        :created_at => nil,
        :updated_at => nil
    }
  end
end
