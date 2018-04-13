class AddBatchIdToInterns < ActiveRecord::Migration[5.1]
  def change
    add_column :interns, :batch_id, :integer
  end
end
