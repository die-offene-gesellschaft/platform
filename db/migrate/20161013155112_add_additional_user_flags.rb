class AddAdditionalUserFlags < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :vip, :boolean
    add_column :users, :good_photo, :boolean
    add_column :users, :good_statement, :boolean
    add_column :users, :contributor, :boolean
  end
end
