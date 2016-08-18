class Event < ApplicationRecord
  has_and_belongs_to_many :participants,
                          class_name: 'User',
                          join_table: 'event_participations'
end
