class ActiveMember < ApplicationRecord
  belongs_to :event

  validates :forename, :surname,
            presence: true

  def full_name
    "#{forename} #{surname}"
  end
end
