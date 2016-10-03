require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:press_reviews) }

  it { should have_many(:statements) }

  it { should have_many(:comments).dependent(:destroy) }

  it { should have_many(:pictures).dependent(:destroy) }

  it { should have_and_belong_to_many(:active_members) }

  it { should belong_to(:venue) }

  it do
    should have_and_belong_to_many(:participants)
      .class_name('User')
      .join_table('event_participations')
  end

  it { should validate_presence_of(:title) }

  it { should validate_presence_of(:begin_at) }

  it { should validate_presence_of(:end_at) }

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:venue) }
end
