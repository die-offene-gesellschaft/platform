class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :event_type
      t.datetime :begin_at
      t.datetime :end_at
      t.string :active_members
      t.text :description
      t.string :facebook_identifier
      t.boolean :locked

      t.timestamps
    end
  end
end
