class RenameSlideTypeInSlides < ActiveRecord::Migration[5.0]
  def change
    rename_column :slides, :slide_type, :slide_mode
  end
end
