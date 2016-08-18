class AddEventToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :event, index: true, foreign_key: true
  end
end
