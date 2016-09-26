class SplitNewsletterNameToForeAndSurname < ActiveRecord::Migration[5.0]
  def change
    rename_column :newsletters, :name, :forename
    add_column :newsletters, :surname, :string

    Newsletter.all.each do |newsletter|
      forename, surname, rest = newsletter.forename.split(' ')
      unless rest
        newsletter.forename = forename
        newsletter.surname = surname
        newsletter.save
      end
    end
  end
end
