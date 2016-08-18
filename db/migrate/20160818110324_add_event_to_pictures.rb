class AddEventToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :event, :reference
  end
end
