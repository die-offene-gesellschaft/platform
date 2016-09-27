class User < ApplicationRecord
  # Others available devise modules are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :confirmable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_and_belongs_to_many :participating_events,
                          class_name: 'Event',
                          join_table: 'event_participations'

  has_and_belongs_to_many :friends,
                          join_table: 'friendships',
                          foreign_key: :friend_id,
                          class_name: 'User'

  has_attached_file :avatar,
                    styles: { normal: ['400x', :jpg] }

  has_many :events
  has_many :comments
  has_many :pictures

  validates_attachment_content_type :avatar,
                                    content_type: %r{\Aimage\/.*\z}

  validates :forename, :surname,
            presence: true

  def after_confirmation
    send_user_welcome_mail if terms_of_use
    sync_to_mailchimp_later if newsletter
  end

  def full_name
    "#{forename} #{surname}"
  end

  private

  def sync_to_mailchimp_later
    delay.sync_to_mailchimp
  end

  def send_user_welcome_mail
    UserWelcomeMailer.user_welcome_email(self).deliver_later
  end

  def sync_to_mailchimp
    gb = Gibbon::API.new
    gb.lists.subscribe mailchimp_hash
  rescue Gibbon::MailChimpError
    true
  end

  def mailchimp_hash
    {
      id: ENV['MAILCHIMP_LIST_ID'],
      email: { email: email },
      merge_vars: { FNAME: forename, LNAME: surname },
      double_optin: false
    }
  end
end
