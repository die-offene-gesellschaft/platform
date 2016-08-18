class Picture < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_attached_file :picture

  validates :picture,
            attachment_presence: true
  validates_attachment_content_type :picture,
                                    content_type: %r{\Aimage\/.*\z}
end
