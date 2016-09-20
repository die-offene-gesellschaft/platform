class Statement < ApplicationRecord
  belongs_to :event

  validates :content,
            presence: true
end
