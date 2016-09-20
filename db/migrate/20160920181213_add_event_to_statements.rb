class AddEventToStatements < ActiveRecord::Migration[5.0]
  def change
    add_reference :statements, :event, index: true, foreign_key: true
  end
end
