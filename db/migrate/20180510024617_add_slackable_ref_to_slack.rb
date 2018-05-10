class AddSlackableRefToSlack < ActiveRecord::Migration[5.1]
  def change
    add_reference :slack_info, :slackable, polymorphic: true
  end
end
