class AddTypeToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :type, :string
  end
end
