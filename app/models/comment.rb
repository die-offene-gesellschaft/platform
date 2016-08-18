class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :event, :user, :message,
            presence: true
end
