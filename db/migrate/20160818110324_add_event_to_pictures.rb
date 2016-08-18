class AddEventToPictures < ActiveRecord::Migration[5.0]
  def change
    add_reference :pictures, :event, index: true, foreign_key: true
  end
end
