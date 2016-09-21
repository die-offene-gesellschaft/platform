class CreatePressReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :press_reviews do |t|
      t.string :source_url
      t.string :source_title
      t.string :title
      t.text :description
      t.string :link

      t.timestamps
    end
  end
end
