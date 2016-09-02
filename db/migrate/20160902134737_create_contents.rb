class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :controller_action_name
      t.string :key
      t.text :value
      t.integer :order

      t.timestamps
    end
  end
end
