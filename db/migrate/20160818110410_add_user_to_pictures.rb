class AddUserToPictures < ActiveRecord::Migration[5.0]
  def change
    add_reference :pictures, :user, index: true, foreign_key: true
  end
end
