class AddVenueToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :venue, :reference
  end
end
