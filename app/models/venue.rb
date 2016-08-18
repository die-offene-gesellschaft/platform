class Venue < ApplicationRecord
  has_many :events
  belongs_to :location, dependent: :destroy
end
