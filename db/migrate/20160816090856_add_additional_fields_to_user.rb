class AddAdditionalFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string
    add_column :users, :statement, :string
    add_column :users, :locked, :boolean
  end
end
