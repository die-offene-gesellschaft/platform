class PressReview < ApplicationRecord
  belongs_to :event

  validates :source_url, :source_title, :title, :description, :link,
            presence: true
end
