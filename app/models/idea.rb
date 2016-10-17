class Idea < ApplicationRecord
  validates :subject, :time, :location, :contact_person, :email,
            presence: true

  validates :email,
            format: { with: /\A\S+@\S+\.\S+\z/ }

  validates :contact_person, :organisation, :email, :phone,
            length: { maximum: 140 }

  validates :subject, :time, :location,
            length: { maximum: 255 }
end
