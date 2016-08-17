class AddAttachmentPictureToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :events, :picture
  end
end
