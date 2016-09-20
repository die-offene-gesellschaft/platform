class CreateStatements < ActiveRecord::Migration[5.0]
  def change
    create_table :statements do |t|
      t.string :question
      t.string :content
      t.string :author

      t.timestamps
    end
  end
end
