class CreateJoinTableEventUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :events, :users, table_name: 'event_participations' do |t|
      t.index [:event_id, :user_id]
      t.index [:user_id, :event_id]
    end
    add_foreign_key :event_participations, :events
    add_foreign_key :event_participations, :users
  end
end
