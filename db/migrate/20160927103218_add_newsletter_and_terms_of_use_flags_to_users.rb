class AddNewsletterAndTermsOfUseFlagsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :newsletter, :boolean, default: false
    add_column :users, :terms_of_use, :boolean, default: false

    User.all.each do |user|
      user.newsletter = false
      user.terms_of_use = true
      user.save
    end
  end
end
