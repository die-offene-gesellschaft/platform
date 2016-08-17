class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :street
      t.string :zip_code
      t.string :city
      t.text :description
      t.boolean :locked

      t.timestamps
    end
  end
end
