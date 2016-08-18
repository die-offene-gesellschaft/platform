class AddUserToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :user, :reference
  end
end
