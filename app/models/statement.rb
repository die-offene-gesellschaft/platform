class Statement < ApplicationRecord
  belongs_to :event

  validates :content,
            :author,
            presence: true
end
