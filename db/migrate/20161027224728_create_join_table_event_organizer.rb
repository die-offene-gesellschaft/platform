class CreateJoinTableEventOrganizer < ActiveRecord::Migration[5.0]
  def change
    create_join_table :events, :organizers do |t|
      t.index [:event_id, :organizer_id]
      t.index [:organizer_id, :event_id]
    end
    add_foreign_key :events_organizers, :events
    add_foreign_key :events_organizers, :organizers
  end
end
