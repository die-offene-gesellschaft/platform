class AddPostDescriptionSourceToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :post_description_source, :string
  end
end
