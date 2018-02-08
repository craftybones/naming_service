class AddMoreFieldsToIntern < ActiveRecord::Migration[5.1]
  def change
    add_column :interns, :emp_id, :integer
    add_column :interns, :dob, :date
    add_column :interns, :gender, :string
  end
end
