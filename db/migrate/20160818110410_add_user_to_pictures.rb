class AddUserToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :user, :reference
  end
end
