class DropNewsletterModel < ActiveRecord::Migration[5.0]
  def change
    Newsletter.all.each do |newsletter|
      user = User.find_by email: newsletter.email
      if user
        user.newsletter = true
      else
        user = User.new forename: newsletter.forename,
                        surname: newsletter.surname,
                        email: newsletter.email,
                        password: SecureRandom.hex,
                        newsletter: true,
                        terms_of_use: false
      end
      user.save
    end if defined?(Newsletter)

    drop_table :newsletters
  end
end
