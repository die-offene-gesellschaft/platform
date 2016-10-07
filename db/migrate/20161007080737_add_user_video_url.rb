class AddUserVideoUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :video_url, :string
  end
end
