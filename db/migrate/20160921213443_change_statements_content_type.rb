class ChangeStatementsContentType < ActiveRecord::Migration[5.0]
  def change
    change_column :statements, :content, :text
  end
end
