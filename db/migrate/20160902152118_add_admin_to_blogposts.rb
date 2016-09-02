class AddAdminToBlogposts < ActiveRecord::Migration[5.0]
  def change
    add_reference :blogposts, :admin, index: true, foreign_key: true
  end
end
