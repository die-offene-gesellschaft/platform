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

  def full_name
    name
  end
end
