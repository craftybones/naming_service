class CreateDropboxes < ActiveRecord::Migration[5.1]
  def change
    create_table :dropbox_info do |t|
      t.references :intern, foreign_key: true
      t.string :username

      t.timestamps
    end
  end
end
