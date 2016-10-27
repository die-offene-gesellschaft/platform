class Blogpost < ApplicationRecord
  belongs_to :admin

  has_attached_file :hero,
                    styles: { normal: ['1200x', :jpg] }
  has_attached_file :thumbnail,
                    styles: { normal: ['400x', :jpg] }

  validates_attachment_content_type :hero,
                                    content_type: %r{\Aimage\/.*\z}
  validates_attachment_content_type :thumbnail,
                                    content_type: %r{\Aimage\/.*\z}

  def self.enough_published?
    Blogpost.where(published: true).where('date <= ?', Time.zone.now).count >= 2
  end
end
