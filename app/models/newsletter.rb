class Newsletter < ApplicationRecord
  after_commit :sync_to_mailchimp_later,
               on: :create

  validates :forename, :surname, :email,
            presence: true

  def sync_to_mailchimp_later
    delay.sync_to_mailchimp
  end

  private

  def sync_to_mailchimp
    gb = Gibbon::API.new
    gb.lists.subscribe id: ENV['MAILCHIMP_LIST_ID'],
                       email: {
                         email: email
                       },
                       merge_vars: {
                         FNAME: forename,
                         LNAME: surname
                       },
                       double_optin: false
  end
end
