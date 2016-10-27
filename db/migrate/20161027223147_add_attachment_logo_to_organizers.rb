class AddAttachmentLogoToOrganizers < ActiveRecord::Migration
  def self.up
    change_table :organizers do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :organizers, :logo
  end
end
