class CreateActiveMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :active_members do |t|
      t.string :forename
      t.string :surname
      t.string :role

      t.timestamps
    end
  end
end
