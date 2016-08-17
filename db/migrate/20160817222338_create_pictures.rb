class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.text :description
      t.boolean :locked

      t.timestamps
    end
  end
end
