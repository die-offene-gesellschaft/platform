require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:comments) }

  it { should have_many(:pictures) }

  it { should belong_to(:venue) }

  it do
    should have_and_belong_to_many(:participants)
      .class_name('User')
      .join_table('event_participations')
  end
end
