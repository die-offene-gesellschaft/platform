class Venue < ApplicationRecord
  has_many :events
  belongs_to :location, dependent: :destroy

  validates :name, :street, :zip_code, :city,
            presence: true
end
