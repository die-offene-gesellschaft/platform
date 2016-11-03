class ConvertBlogpostsAdminReferenceToTextfield < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:blogposts, :admin, index: true, foreign_key: true)
    add_column :blogposts, :author, :string
  end
end
