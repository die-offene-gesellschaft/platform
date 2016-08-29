class ActiveMember < ApplicationRecord
  belongs_to :event

  validates :forename, :surname,
            presence: true
end
