class AddAttachmentHeroToBlogposts < ActiveRecord::Migration
  def self.up
    change_table :blogposts do |t|
      t.attachment :hero
    end
  end

  def self.down
    remove_attachment :blogposts, :hero
  end
end
