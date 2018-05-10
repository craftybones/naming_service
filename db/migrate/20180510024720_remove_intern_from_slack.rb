class RemoveInternFromSlack < ActiveRecord::Migration[5.1]
  def change
    remove_column :slack_info, :intern_id, :string
  end
end
