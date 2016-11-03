class AddSlugsToBlogposts < ActiveRecord::Migration[5.0]
  def change
    add_column :blogposts, :slug, :string
  end
end
