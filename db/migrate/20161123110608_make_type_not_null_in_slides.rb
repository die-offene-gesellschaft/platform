class MakeTypeNotNullInSlides < ActiveRecord::Migration[5.0]
  def change
    Slide.update_all(type: "text")
    change_column :slides, :type, :string, :null => false
  end
end
