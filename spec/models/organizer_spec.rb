require 'rails_helper'

RSpec.describe Organizer, type: :model do
  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(140) }

  it { should validate_presence_of(:url) }

  it { should validate_length_of(:url).is_at_most(140) }

  it { should validate_presence_of(:logo) }

  it { should have_and_belong_to_many(:events) }
end
