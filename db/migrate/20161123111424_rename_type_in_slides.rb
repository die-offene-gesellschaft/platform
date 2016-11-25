class RenameTypeInSlides < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :slides, :type, :slide_type
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
