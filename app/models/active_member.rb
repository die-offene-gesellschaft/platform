class ActiveMember < ApplicationRecord
  has_and_belongs_to_many :events

  validates :forename, :surname,
            presence: true

  def full_name
    "#{forename} #{surname}"
  end
end
