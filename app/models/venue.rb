class Venue < ApplicationRecord
  has_many :events
  belongs_to :location
end
