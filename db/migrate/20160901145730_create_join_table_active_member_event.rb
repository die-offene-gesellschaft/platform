class CreateJoinTableActiveMemberEvent < ActiveRecord::Migration[5.0]
  def change
    create_join_table :active_members, :events do |t|
      t.index [:active_member_id, :event_id]
      t.index [:event_id, :active_member_id]
    end

    add_foreign_key :active_members_events, :active_members
    add_foreign_key :active_members_events, :events
  end
end
