class AddDateAndPublishFlagToBlogposts < ActiveRecord::Migration[5.0]
  def change
    add_column :blogposts, :date, :datetime
    add_column :blogposts, :published, :boolean
  end
end
