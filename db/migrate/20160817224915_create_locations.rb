class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :radius

      t.timestamps
    end
  end
end
