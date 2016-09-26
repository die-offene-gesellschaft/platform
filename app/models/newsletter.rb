class Newsletter < ApplicationRecord
  validates :forename, :surname, :email,
            presence: true
end
