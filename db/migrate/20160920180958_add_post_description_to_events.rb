class AddPostDescriptionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :post_description, :text
  end
end
