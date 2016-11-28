class Slide < ApplicationRecord
  SLIDE_TYPES = %w(text quote picture).freeze

  has_attached_file :picture,
                    styles: { normal: ['800x400#', :jpg] }

  validates :slide_mode, inclusion: { in: SLIDE_TYPES }, presence: true

  validates :picture, dimensions: { width: 800, height: 400 }
  validates_attachment_content_type :picture,
                                    content_type: %r{\Aimage\/.*\z}
  validates :order, presence: true
end
