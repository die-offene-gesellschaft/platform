class AddOrderToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :order, :integer
  end
end
