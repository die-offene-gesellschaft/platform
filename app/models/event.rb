class Event < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy

  has_and_belongs_to_many :participants,
                          class_name: 'User',
                          join_table: 'event_participations'

  validates :title, :event_type, :begin_at, :end_at, :description, :venue,
            presence: true
end
