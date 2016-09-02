class CreateBlogposts < ActiveRecord::Migration[5.0]
  def change
    create_table :blogposts do |t|
      t.string :title
      t.string :blogpost_type
      t.text :introduction
      t.text :content

      t.timestamps
    end
  end
end
