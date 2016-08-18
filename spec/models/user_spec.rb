require 'rails_helper'

RSpec.describe User, type: :model do
  it do
    should have_and_belong_to_many(:participating_events)
      .class_name('Event')
      .join_table('event_participations')
  end
end
