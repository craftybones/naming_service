class RemoveBatchFromInterns < ActiveRecord::Migration[5.1]
  def change
    remove_column :interns, :batch, :integer
  end
end
