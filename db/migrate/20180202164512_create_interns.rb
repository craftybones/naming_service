class CreateInterns < ActiveRecord::Migration[5.1]
  def change
    create_table :interns do |t|
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.integer :batch

      t.timestamps
    end
  end
end
