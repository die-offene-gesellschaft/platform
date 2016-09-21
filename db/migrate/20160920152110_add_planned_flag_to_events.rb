class AddPlannedFlagToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :planned, :boolean
  end
end
