class AddAttachmentThumbnailToBlogposts < ActiveRecord::Migration
  def self.up
    change_table :blogposts do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :blogposts, :thumbnail
  end
end
