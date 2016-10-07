class User < ApplicationRecord
  before_save :send_user_welcome_mail, if: :locked_changed?

  # Others available devise modules are: # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
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

  validates :forename,
            :surname,
            presence: true

  validates :password,
            confirmation: true

  validates :role,
            length: { maximum: 140 }

  validates :statement,
            length: { maximum: 255 }

  validate do |user|
    UserFlagsValidator.validate_terms_of_use(user)
    UserVideoUrlsValidator.validate_video_url(user)
  end

  def after_confirmation
    send_user_welcome_mail if terms_of_use
    sync_to_mailchimp_later if newsletter
  end

  def full_name
    "#{forename} #{surname}"
  end

  def large_image?
    false
  end

  def video_user?
    video_url.present?
  end

  def youtube_id
    return nil unless video_user?
    %r{
      https:\/\/(
      www.youtube.com\/watch\?v=(?<youtube_id>[a-zA-Z0-9]+)|
      youtu.be\/(?<youtube_id>[a-zA-Z0-9]+)
      )
    }x =~ video_url
    youtube_id
  end

  def vimeo_id
    return nil unless video_user?
    %r{
      https:\/\/(
      vimeo.com\/(?<vimeo_id>[0-9]+)
      )
    }x =~ video_url
    vimeo_id
  end

  private

  def sync_to_mailchimp_later
    delay.sync_to_mailchimp
  end

  def send_user_welcome_mail
    UserWelcomeMailer.user_welcome_email(self).deliver_later if id && !locked && terms_of_use
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
