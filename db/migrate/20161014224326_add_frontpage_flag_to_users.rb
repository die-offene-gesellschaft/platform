class AddFrontpageFlagToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :frontpage, :boolean
  end
end
