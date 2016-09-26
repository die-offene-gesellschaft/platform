class SplitUsersNameToForeAndSurname < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :forename
    add_column :users, :surname, :string

    User.all.each do |user|
      forename, surname, rest = user.forename.split(' ')
      unless rest
        user.forename = forename
        user.surname = surname
        user.save
      end
    end
  end
end
