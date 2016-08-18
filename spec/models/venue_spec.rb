require 'rails_helper'

RSpec.describe Venue, type: :model do
  it { should have_many(:events) }

  it { should belong_to(:location).dependent(:destroy) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:street) }

  it { should validate_presence_of(:zip_code) }

  it { should validate_presence_of(:city) }
end
