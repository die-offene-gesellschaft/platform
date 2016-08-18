class AddEventToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :event, :reference
  end
end
