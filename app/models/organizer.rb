class Organizer < ApplicationRecord
  has_and_belongs_to_many :events

  has_attached_file :logo,
                    styles: { normal: ['200'] }
  validates_attachment_content_type :logo,
                                    content_type: %r{\Aimage\/.*\z}

  validates :name, :url, :logo,
            presence: true

  validates :name, :url,
            length: { maximum: 140 }
end
