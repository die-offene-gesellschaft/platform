require 'rails_helper'

RSpec.describe Event, type: :model do
  it do
    should have_and_belong_to_many(:participants)
      .class_name('User')
      .join_table('event_participations')
  end
end
