class AddUserToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :user, :reference
  end
end
