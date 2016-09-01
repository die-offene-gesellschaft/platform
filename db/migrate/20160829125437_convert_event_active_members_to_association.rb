class ConvertEventActiveMembersToAssociation < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :active_members
  end
end
