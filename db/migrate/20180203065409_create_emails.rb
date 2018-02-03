class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.references :intern, foreign_key: true
      t.string :category
      t.string :address

      t.timestamps
    end
  end
end
