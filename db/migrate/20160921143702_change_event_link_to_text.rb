class ChangeEventLinkToText < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :link, :text
  end
end
