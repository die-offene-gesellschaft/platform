class AddColorToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :color, :string
  end
end
