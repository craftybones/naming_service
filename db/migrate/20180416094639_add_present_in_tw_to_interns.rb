class AddPresentInTwToInterns < ActiveRecord::Migration[5.1]
  def change
    add_column :interns, :present_in_tw, :boolean
  end
end
