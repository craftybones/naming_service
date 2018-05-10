class RemoveInternFromEmails < ActiveRecord::Migration[5.1]
  def change
    remove_column :emails, :intern_id, :string
  end
end
