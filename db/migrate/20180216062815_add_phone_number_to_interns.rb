class AddPhoneNumberToInterns < ActiveRecord::Migration[5.1]
  def change
    add_column :interns, :phone_number, :string
  end
end
