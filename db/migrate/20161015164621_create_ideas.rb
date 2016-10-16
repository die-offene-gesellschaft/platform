class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.text :subject
      t.text :time
      t.text :location
      t.string :contact_person
      t.string :organisation
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
