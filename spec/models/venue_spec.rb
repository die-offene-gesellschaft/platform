require 'rails_helper'

RSpec.describe Venue, type: :model do
  it { should have_many(:events) }

  it { should belong_to(:location).dependent(:destroy) }
end
