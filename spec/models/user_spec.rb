require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:pictures) }

  it { should have_many(:comments) }

  it { should have_many(:events) }

  it do
    should have_and_belong_to_many(:participating_events)
      .class_name('Event')
      .join_table('event_participations')
  end
end
