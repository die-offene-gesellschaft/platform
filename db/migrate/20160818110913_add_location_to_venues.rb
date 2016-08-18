class AddLocationToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :location, :reference
  end
end
