class Event < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  has_many :press_reviews
  has_many :statements
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_and_belongs_to_many :active_members
  has_and_belongs_to_many :organizers

  has_and_belongs_to_many :participants,
                          class_name: 'User',
                          join_table: 'event_participations'

  has_attached_file :picture,
                    styles: { normal: ['800x800^', :jpg],
                              logo: ['250x250^', :png] }

  validates :link, :url => {:allow_nil => true, :allow_blank => true}

  validates :title,
            :begin_at,
            :end_at,
            :description,
            :venue,
            presence: true

  validates_attachment_content_type :picture,
                                    content_type: %r{\Aimage\/.*\z}

  def moments
    statements.where(question: [nil, ''])
  end

  def quotes
    statements.where.not(question: [nil, ''])
  end
end
