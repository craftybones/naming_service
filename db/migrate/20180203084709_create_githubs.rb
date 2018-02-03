class CreateGithubs < ActiveRecord::Migration[5.1]
  def change
    create_table :github_infos do |t|
      t.references :intern, foreign_key: true
      t.string :username

      t.timestamps
    end
  end
end
