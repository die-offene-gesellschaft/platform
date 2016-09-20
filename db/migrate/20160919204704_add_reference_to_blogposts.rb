class AddReferenceToBlogposts < ActiveRecord::Migration[5.0]
  def change
    add_column :blogposts, :reference, :string
  end
end
