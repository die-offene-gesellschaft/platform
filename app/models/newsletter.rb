class Newsletter < ApplicationRecord
  validates :name, :email,
            presence: true
end
