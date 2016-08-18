class AddLocationToVenues < ActiveRecord::Migration[5.0]
  def change
    add_reference :venues, :location, index: true, foreign_key: true
  end
end
