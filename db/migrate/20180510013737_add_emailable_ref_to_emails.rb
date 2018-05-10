class AddEmailableRefToEmails < ActiveRecord::Migration[5.1]
  def change
    add_reference :emails, :emailable, polymorphic: true
  end
end
