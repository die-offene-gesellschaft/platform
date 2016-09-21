class RenamePlannedEventAttribute < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :planned, :planed
  end
end
