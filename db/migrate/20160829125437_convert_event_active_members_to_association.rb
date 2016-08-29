class ConvertEventActiveMembersToAssociation < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :active_members
    add_reference :active_members, :event, index: true, foreign_key: true
  end
end
