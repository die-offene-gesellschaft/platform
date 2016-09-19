class PressReview < ApplicationRecord
  validates :source_url, :source_title, :title, :description, :link,
            presence: true
end
