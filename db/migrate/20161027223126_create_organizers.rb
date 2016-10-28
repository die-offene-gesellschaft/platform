class CreateOrganizers < ActiveRecord::Migration[5.0]
  def change
    create_table :organizers do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
