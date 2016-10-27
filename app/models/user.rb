class User < ApplicationRecord
  before_save :send_user_welcome_mail, if: :locked_changed?

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
                    styles: { normal: ['400x400^', :jpg],
                              large: ['800x800^', :jpg] }

  validates :avatar, dimensions: { width: 500, height: 500 }

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

  def full_name
    "#{forename} #{surname}"
  end

  def video_user?
    !frontpage && video_url.present?
  end

  def youtube_id
    return nil unless video_user?
    %r{
      https:\/\/(
      www.youtube.com\/watch\?v=(?<youtube_id>[a-zA-Z0-9\-_]+)|
      youtu.be\/(?<youtube_id>[a-zA-Z0-9\-_]+)
      )
    }x =~ video_url
    youtube_id
  end

  def youtube_preview_url
    return nil unless youtube_id
    "https://img.youtube.com/vi/#{youtube_id}/0.jpg"
  end

  def vimeo_preview_url
    return nil unless vimeo_id
    response = open("http://vimeo.com/api/v2/video/#{vimeo_id}.json").read
    json_response = JSON.parse(response)
    json_response[0]['thumbnail_large'].gsub(/^http:/, 'https:')
  rescue
    nil
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

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def self.apply_filters(collection, params)
    collection.reject do |user|
      !user.confirmed_at && params['filter-email-confirmed'] == 'true' ||
        !user.locked && params['filter-locked'] == 'true' ||
        !user.newsletter && params['filter-newsletter'] == 'true' ||
        !user.terms_of_use && params['filter-terms-of-use'] == 'true' ||
        !user.vip && params['filter-vip'] == 'true' ||
        !user.good_photo && params['filter-good-photo'] == 'true' ||
        !user.good_statement && params['filter-good-statement'] == 'true' ||
        !user.contributor && params['filter-contributor'] == 'true' ||
        !user.video_user? && params['filter-video-url'] == 'true' ||
        !user.frontpage && params['filter-frontpage'] == 'true'
    end
  end

  # this method smells of :reek:DuplicateMethodCall
  def self.filter_for_pictures(collection)
    video_users = collection.where.not(video_url: [nil, ''])
                            .where.not(avatar_file_name: nil)
    statement_users = collection.where.not(statement: [nil, ''])
                                .where(good_statement: true)
                                .where.not(id: video_users.map(&:id))
    picture_users = collection.where.not(avatar_file_name: nil)
                              .where(good_photo: true)
                              .where.not(id: video_users.map(&:id))
                              .where.not(id: statement_users.map(&:id))
    users = collection.where.not(avatar_file_name: nil)
                      .where.not(id: video_users.map(&:id))
                      .where.not(id: statement_users.map(&:id))
                      .where.not(id: picture_users.map(&:id))
    [video_users, statement_users, picture_users, users]
  end

  private

  def after_confirmation
    return if locked
    send_user_welcome_mail if terms_of_use
    sync_to_mailchimp_later if newsletter
  end

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
